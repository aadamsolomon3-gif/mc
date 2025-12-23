#!/bin/bash

# ===============================
# Interactive Git Setup Script
# ===============================

echo "=== Git Setup ==="

# Ask for Git user name
read -p "Enter your Git user name: " GIT_NAME

# Ask for Git email
read -p "Enter your Git email: " GIT_EMAIL

# Set Git global name and email
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Set VS Code as the default Git editor
git config --global core.editor "code --wait"

echo "Git has been configured successfully!"
echo "Here is your current Git configuration:"
git config --list
