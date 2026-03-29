# Shitty script to configure new laptops
MOSAICO_LABS_PATH="workspace/mosaico-labs"

sudo apt update

# Installing packages
sudo apt install  -y build-essential make \
                     curl wget wireguard \
                     git gh \
                     python3-venv \
                     podman \
                     distrobox \
                     ripgrep jq fzf xclip 

# Install 1Password (https://support.1password.com/install-linux/#debian-or-ubuntu)
if [ ! -f /etc/apt/sources.list.d/1password.list ]; then
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
    sudo apt update
fi
sudo apt install -y 1password

# Installing Rust toolchain 
if ! command -v rustup &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s 
fi

# Installing Poetry 
if ! command -v poetry &> /dev/null; then
    curl -sSL https://install.python-poetry.org | python3 -
fi

# Create default directories
cd ~
mkdir -p "$MOSAICO_LABS_PATH"

# Add message for new users
cat << 'EOF' >> ~/.bashrc

# ---- DELETE THESE LINES -----
echo ""
echo "Hi, welcome to mosaico!"
echo ""
echo "Here is a list of steps to finish your laptop configuration."
echo ""
echo "1. Generate a new SSH key:"
echo "     ssh-keygen -t ed25519 -C \"$(whoami)@$(hostname)\""
echo "     cat ~/.ssh/id_ed25519.pub"
echo ""
echo "2. Clone mosaico:"
echo "     cd ~/workspace/mosaico-labs"
echo "     git clone git@github.com:mosaico-labs/mosaico.git"
echo ""
echo "3. Configure 1Password browser extension:"
echo "     https://1password.com/downloads/browser-extension"
echo "   The desktop application is already installed on this machine."
echo ""
echo "When finished, delete these lines from ~/.bashrc to HIDE THIS MESSAGE."
echo ""
# -----------------------------
EOF

