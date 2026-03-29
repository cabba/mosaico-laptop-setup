# Shitty script to configure new laptops

MOSAICO_LABS_PATH="workspace/mosaico-labs"

sudo apt update

echo "Installing packages"
sudo apt install  build-essential make \
                  curl wget wireguard \
                  git gh \
                  python3-venv \
                  podman \
                  distrobox \
                  ripgrep jq fzf xclip 

echo "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Installing Poetry"
curl -sSL https://install.python-poetry.org | python3 -


echo "Setup environment"
cd ~
mkdir -p "$MOSAICO_LABS_PATH"

echo "Completed"

cat << EOF

Now the final steps:

1. Generate a new SSH key with:

    ssh-keygen

and add the key to your github account.

2. Clone mosaico repository to ~/workspace/mosaico-labs with:

    git clone git@github.com:mosaico-labs/mosaico.git

EOF

