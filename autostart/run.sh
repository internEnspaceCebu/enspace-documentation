#!/bin/bash
set -e

# this script uses the tmux terminal multiplexer 
# to keep a terminal session alive for the program
# and for user monitoring
# for ease of use, just change SETUP and COMMANDS
# ===============================================
# SETUP
# ===============================================

SESSION_NAME="enspace-doc"
DIR="$HOME/git/enspace-documentation"

# ===============================================
# FUNCTIONS
# ===============================================
LOG="$DIR/autostart/${SESSION_NAME}.log"
exec > >(tee -a "$LOG") 2>&1

# wont stop if tmux session notif already exists
tmux new -d -s "$SESSION_NAME" || true		
tmux_send_keys(){
	local command_string=$1
	tmux send-keys -t "$SESSION_NAME" "$command_string" C-m
}

# ===============================================
# COMMANDS
# ===============================================

tmux_send_keys "cd $DIR"
tmux_send_keys "npm start -- --port 8999"