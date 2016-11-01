xcode:
	xcode-select --install
brew:
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
setup:
	brew doctor
	brew update
	brew install python
	brew install ansible
all:
	HOMEBREW_CASK_OPTS="--appdir=/Applications" ansible-playbook -i hosts -vv localhost.yml
brew-packages:
	HOMEBREW_CASK_OPTS="--appdir=/Applications" ansible-playbook -i hosts -vv localhost.yml --start-at="brew パッケージをインストール" --step
cask-packages:
	HOMEBREW_CASK_OPTS="--appdir=/Applications" ansible-playbook -i hosts -vv localhost.yml --start-at="cask パッケージをインストール" --step
brew-search:
	brew search | grep ${SEARCH}
cask-search:
	brew cask search | grep ${SEARCH}
karabiner:
	chmod +x karabiner-import.sh | sh karabiner-import.sh