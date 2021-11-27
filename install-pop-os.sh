sudo apt update && sudo apt upgrade


# Create directory for AppImages if it does not already exist
mkdir -p .local/bin


# Apt Installs
sudo apt install vim gnome-tweaks code firefox discord fonts-firacode obs-studio azure-cli


# https://www.microsoftedgeinsider.com/en-us/download?platform=linux-deb
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-beta.list'
sudo rm microsoft.gpg
sudo apt update
sudo apt install microsoft-edge-beta
xdg-settings set default-web-browser microsoft-edge-beta.desktop


# https://www.spotify.com/au/download/linux/
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client


# https://bitwarden.com/download/
curl -s https://api.github.com/repos/bitwarden/desktop/releases/latest \
| grep "browser_download_url.*AppImage" \
| cut -d '"' -f 4 \
| wget -i -
chmod a+x Bitwarden*AppImage
mv Bitwarden*AppImage $HOME/.local/bin/


# https://docs.docker.com/engine/install/ubuntu/
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo apt install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
