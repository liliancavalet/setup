#!/bin/bash
sudo apt update && upgrade

echo '******** GEDIT INSTALLATION ********'
sudo apt install gedit -y

echo '******** VIM INSTALLATION ********'
sudo apt install vim -y

echo '******** cURL INSTALLATION ********'
sudo apt install curl -y

echo '******** xCLIP INSTALLATION ********'
sudo apt install xclip -y

echo '******** GIT INSTALLATION AND CONFIGURATION ********'
sudo apt install git -y

echo "What name do you want to use in GIT user.name?"
read git_config_user_name
git config --global user.name "$git_config_user_name"
clear 

echo "What email do you want to use in GIT user.email?"
read git_config_user_email
git config --global user.email "$git_config_user_email"
clear

echo "Set VIM as default GIT editor"
git config --global core.editor vim

echo "Generating a SSH Key"
ssh-keygen -t rsa -b 4096 -C "$git_config_user_email"
ssh-add ~/.ssh/id_rsa

echo "ACTION REQUIRED:"
echo "Add this SSH key to your version control repository"
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard
echo "Press enter when completed"
read -r

echo '******** SDKMAN INSTALLATION AND CONFIGURATION ********'
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

echo '******** JAVA INSTALLATION AND CONFIGURATION ********'
sdk list java
echo "What java version do you want to install? (ex.: x.y.z-oracle)"
read java_version
sdk install java java_version

echo '******** INTELLIJ INSTALLATION ********'
sudo snap install intellij-idea-community --classic

echo '******** ZOOM INSTALLATION ********'
sudo snap install zoom-client

echo '******** DOCKER ENGINE INSTALLATION ********'
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER

echo '******** NVM INSTALLATION AND CONFIGURATION ********'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc   # Or ~/.zshrc if you're using Zsh
nvm --version

echo '******** NODE INSTALLATION AND CONFIGURATION ********'
nvm ls-remote
echo "What Node version do you want to install? (ex.: v22.13.0)"
read node_version
nvm install node_version

echo '******** VSCode INSTALLATION AND CONFIGURATION ********'
sudo snap install code --classic

echo 'Extensions:'
echo 'Prettier code formatter' 
code --install-extension esbenp.prettier-vscode
echo 'Bracket Pair Colorizer' 
code --install-extension CoenraadS.bracket-pair-colorizer
echo 'Plant UML support' 
code --install-extension jebbs.plantuml
code --install-extension christian-kohler.path-intellisense
code --install-extension dracula-theme.theme-dracula
code --install-extension foxundermoon.shell-format
code --install-extension yzhang.markdown-all-in-one

echo '******** Z SHELL INSTALLATION AND CONFIGURATION ********'
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
chsh -s $(which zsh)
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
export ZSH_THEME="powerlevel10k/powerlevel10k"

echo '******** HUGO INSTALLATION ********'
echo "What Hugo version do you desire? (x.xxx.x)"
read hugo_version
curl -LO https://github.com/gohugoio/hugo/releases/download/v"$hugo_version"/hugo_"$hugo_version"_linux-amd64.tar.gz
tar -zxvf hugo_"$hugo_version"_linux-amd64.tar.gz
sudo mv hugo /usr/local/bin
hugo -version
rm -rf hugo_"$hugo_version"_linux-amd64.tar.gz
