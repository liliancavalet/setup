sudo apt update && upgrade

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

echo '******** VSCode INSTALLATION AND CONFIGURATION ********'
sudo apt install software-properties-common apt-transport-https wget -y
wget -O- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg
echo deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install code

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
sudo apt-get install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
sudo git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
sudo ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

