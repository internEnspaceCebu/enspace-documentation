#!/bin/bash
set -e

# ===============================================
# SETUP
# ===============================================
absolute_file_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/$(basename -- "${BASH_SOURCE[0]}")"
absolute_folder_path_m0=$(dirname -- "$absolute_file_path")

source "$HOME/.bashrc"
exec 2>>"$absolute_file_path.log"

# ===============================================
# CUSTOM VARS
# ===============================================
session_name=enspace-doc
run_script=run.sh

REPLACEE01="insert_working_directory_01"
REPLACER01="$absolute_folder_path_m0"
REPLACEE02="insert_working_directory_02"
REPLACER02="$absolute_folder_path_m0/$run_script"

# ===============================================

mkdir -p "$HOME/.config/systemd/user"
FILE_TEMPLATE="$absolute_folder_path_m0/template.service"
FILE_OUTPUT="$HOME/.config/systemd/user/$session_name.service"

# ===============================================
# SCRIPT
# ===============================================

sed -e "s|$REPLACEE01|$REPLACER01|" -e "s|$REPLACEE02|$REPLACER02|" "$FILE_TEMPLATE" > "$FILE_OUTPUT"

systemctl --user daemon-reload
systemctl --user enable "$session_name.service"
systemctl --user start "$session_name.service"
