#!/bin/bash
# A bash script to setup my prefered shell environment on ubuntu based linux.

# Exit immediately if a command exits with a non-zero status
set -e

# Install Fish shell
echo "Installing Fish shell..."
sudo apt install -y fish

# Start Fish shell
echo "Starting Fish shell..."
fish

# Change the default shell to Fish
echo "Changing default shell to Fish..."
chsh -s $(which fish)

# Install Starship prompt
echo "Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh

# Create Starship configuration directory if it doesn't exist
mkdir -p ~/.config
echo "Setting up Starship configuration..."
starship preset pure-preset -o ~/.config/starship.toml

# Install Fisher package manager for Fish
echo "Installing Fisher..."
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install jorgebucaran/fisher

# Install nvm.fish and done plugin
echo "Installing nvm.fish, done, and bass plugin..."
fisher install jorgebucaran/nvm.fish
fisher install franciscolourenco/done
fisher install edc/bass

# Install Node.js version 22.13.11 using nvm
echo "Installing Node.js version 22.13.11..."
nvm install 22.13.11 || { echo "Node.js installation failed"; exit 1; }
nvm use 22.13.11

# Install pnpm globally
echo "Installing pnpm globally..."
npm install -g pnpm

# Save custom Fish configuration, replacing existing contents
echo "Saving custom Fish configuration..."
cat << 'EOF' > ~/.config/fish/config.fish
# Hide welcome message & ensure we are reporting fish as shell
set fish_greeting
set -x SHELL /usr/bin/fish

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

# Load nvm
set -x NVM_DIR $HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ]; and . (bass source $NVM_DIR/nvm.sh)

# Load node version without nvm output message
nvm use 22.13.1 > /dev/null 2>&1

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

if status is-interactive
   ## Starship prompt
   if status --is-interactive
      source ("/usr/local/bin/starship" init fish --print-full-init | psub)
   end
end
EOF

echo "Linux shell setup complete!"
