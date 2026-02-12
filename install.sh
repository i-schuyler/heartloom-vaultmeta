#!/usr/bin/env bash
# install.sh
set -euo pipefail

SCRIPT_NAME="install.sh"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="${SCRIPT_DIR}"

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
USER_CONFIG_DIR="${XDG_CONFIG_HOME}/vaultmeta"
CONFIG_TARGET="${USER_CONFIG_DIR}/vaultmeta.conf"
CONFIG_EXAMPLE="${REPO_ROOT}/config/vaultmeta.conf.example"

LOCAL_BIN_DIR="${HOME}/.local/bin"
LOCAL_BIN_TARGET="${LOCAL_BIN_DIR}/vaultmeta"
LOCAL_BIN_SOURCE="${REPO_ROOT}/bin/vaultmeta"

SHORTCUTS_DIR="${HOME}/.shortcuts"
SHORTCUT_NAME="run-vaultmeta"
SHORTCUT_PATH="${SHORTCUTS_DIR}/${SHORTCUT_NAME}"

# marker for uninstall safety (only remove what we created)
INSTALL_MARKER="${REPO_ROOT}/.installed_by_install_sh"

trim() { echo "${1:-}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'; }

prompt() {
  local msg="$1"
  local def="${2:-}"
  local ans=""
  if [[ -n "${def}" ]]; then
    read -r -p "${msg} [default: ${def}] " ans || true
    ans="$(trim "$ans")"
    [[ -z "$ans" ]] && ans="$def"
  else
    read -r -p "${msg} " ans || true
    ans="$(trim "$ans")"
  fi
  echo "$ans"
}

is_termux() {
  if [[ -n "${PREFIX:-}" ]] && [[ "${PREFIX}" == *"com.termux"* ]]; then
    return 0
  fi
  if command -v termux-info >/dev/null 2>&1; then
    return 0
  fi
  return 1
}

ensure_executable() {
  chmod +x "${LOCAL_BIN_SOURCE}" 2>/dev/null || true
}

install_config() {
  mkdir -p "${USER_CONFIG_DIR}"
  if [[ -f "${CONFIG_TARGET}" ]]; then
    echo "Config exists: ${CONFIG_TARGET}"
    return 0
  fi
  if [[ ! -f "${CONFIG_EXAMPLE}" ]]; then
    echo "Missing example config: ${CONFIG_EXAMPLE}" >&2
    exit 1
  fi
  cp "${CONFIG_EXAMPLE}" "${CONFIG_TARGET}"
  echo "Created config: ${CONFIG_TARGET}"
}

edit_config() {
  install_config

  if [[ -n "${EDITOR:-}" ]] && command -v "${EDITOR}" >/dev/null 2>&1; then
    "${EDITOR}" "${CONFIG_TARGET}"
    return 0
  fi

  if command -v nano >/dev/null 2>&1; then
    nano "${CONFIG_TARGET}"
    return 0
  fi

  if command -v vi >/dev/null 2>&1; then
    vi "${CONFIG_TARGET}"
    return 0
  fi

  echo "No editor found. Inline edit (minimal):"
  local vault_root output_dir include_hidden exclude_dirs exclude_globs max_depth follow_symlinks include_files

  vault_root="$(prompt "VAULT_ROOT (path to Obsidian vault root):" "")"
  output_dir="$(prompt "OUTPUT_DIR (press Enter for default inside vault):" "")"
  include_hidden="$(prompt "INCLUDE_HIDDEN (0 or 1):" "0")"
  exclude_dirs="$(prompt "EXCLUDE_DIRS (comma-separated):" ".git,node_modules,.trash,.stfolder")"
  exclude_globs="$(prompt "EXCLUDE_GLOBS (comma-separated):" "*.log,*.tmp,*.bak")"
  max_depth="$(prompt "TREE_MAX_DEPTH:" "6")"
  follow_symlinks="$(prompt "FOLLOW_SYMLINKS (0 or 1):" "0")"
  include_files="$(prompt "INCLUDE_FILES (0 or 1):" "1")"

  cat > "${CONFIG_TARGET}" <<EOF
# vaultmeta.conf
VAULT_ROOT=${vault_root}
OUTPUT_DIR=${output_dir}
INCLUDE_HIDDEN=${include_hidden}
EXCLUDE_DIRS=${exclude_dirs}
EXCLUDE_GLOBS=${exclude_globs}
TREE_MAX_DEPTH=${max_depth}
FOLLOW_SYMLINKS=${follow_symlinks}
INCLUDE_FILES=${include_files}
# vaultmeta.conf EOF
EOF

  echo "Wrote config: ${CONFIG_TARGET}"
}

install_bin() {
  ensure_executable
  mkdir -p "${LOCAL_BIN_DIR}"
  cp "${LOCAL_BIN_SOURCE}" "${LOCAL_BIN_TARGET}"
  chmod +x "${LOCAL_BIN_TARGET}"
  echo "Installed: ${LOCAL_BIN_TARGET}"
  echo "Note: ensure ~/.local/bin is in your PATH."
}

install_shortcut_optional() {
  local ans
  ans="$(prompt "Create Termux:Widget shortcut (${SHORTCUT_NAME})? (y/n):" "y")"
  if [[ "${ans}" != "y" && "${ans}" != "Y" ]]; then
    echo "Skipping shortcut creation (user declined)."
    return 0
  fi

  if ! is_termux; then
    echo "Skipping shortcut creation because Termux shortcut directory does not exist."
    return 0
  fi

  if [[ ! -d "${SHORTCUTS_DIR}" ]]; then
    echo "Skipping shortcut creation because Termux shortcut directory does not exist."
    return 0
  fi

  cat > "${SHORTCUT_PATH}" <<EOF
#!/usr/bin/env bash
# run-vaultmeta
set -euo pipefail

# Prefer installed command; fallback to repo-local if needed.
if command -v vaultmeta >/dev/null 2>&1; then
  vaultmeta "\$@"
  exit 0
fi

if [[ -x "${LOCAL_BIN_TARGET}" ]]; then
  "${LOCAL_BIN_TARGET}" "\$@"
  exit 0
fi

echo "vaultmeta not found. Run ./install.sh install from the repo root." >&2
exit 1

# run-vaultmeta EOF
EOF

  chmod +x "${SHORTCUT_PATH}"
  echo "Installed Termux shortcut: ${SHORTCUT_PATH}"
}

status() {
  echo "Repo: ${REPO_ROOT}"
  echo "Config: ${CONFIG_TARGET} ($( [[ -f "${CONFIG_TARGET}" ]] && echo "exists" || echo "missing" ))"
  echo "Binary: ${LOCAL_BIN_TARGET} ($( [[ -x "${LOCAL_BIN_TARGET}" ]] && echo "installed" || echo "missing" ))"
  echo "Shortcut: ${SHORTCUT_PATH} ($( [[ -x "${SHORTCUT_PATH}" ]] && echo "installed" || echo "missing" ))"
  echo "Termux detected: $(is_termux && echo "yes" || echo "no")"
}

uninstall() {
  # Remove only artifacts we install here
  if [[ -x "${LOCAL_BIN_TARGET}" ]]; then
    rm -f "${LOCAL_BIN_TARGET}"
    echo "Removed: ${LOCAL_BIN_TARGET}"
  fi

  # Remove shortcut only if it matches our expected name
  if [[ -e "${SHORTCUT_PATH}" ]]; then
    rm -f "${SHORTCUT_PATH}"
    echo "Removed: ${SHORTCUT_PATH}"
  fi

  # Remove config only if it was created by copying the example and user wants it removed
  if [[ -f "${CONFIG_TARGET}" ]]; then
    local ans
    ans="$(prompt "Remove config file at ${CONFIG_TARGET}? (y/n):" "n")"
    if [[ "${ans}" == "y" || "${ans}" == "Y" ]]; then
      rm -f "${CONFIG_TARGET}"
      echo "Removed: ${CONFIG_TARGET}"
    else
      echo "Keeping config: ${CONFIG_TARGET}"
    fi
  fi

  rm -f "${INSTALL_MARKER}" 2>/dev/null || true
  echo "Uninstall complete."
}

install_all() {
  touch "${INSTALL_MARKER}"
  install_config
  install_bin
  install_shortcut_optional
  echo "Install complete."
  echo "Try: vaultmeta status"
}

main() {
  local cmd="${1:-install}"
  case "${cmd}" in
    install )
      install_all
      ;;
    uninstall )
      uninstall
      ;;
    edit-config )
      edit_config
      ;;
    status )
      status
      ;;
    * )
      echo "Usage: ./install.sh {install|uninstall|edit-config|status}" >&2
      exit 2
      ;;
  esac
}

main "$@"

# install.sh EOF