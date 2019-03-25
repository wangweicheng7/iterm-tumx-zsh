#!/bin/sh
#
# name     : tmuxen， tmux environment made easy
# author   : Weicheng Wang 809405366@qq.com
# license  : MIT
# created  : 2019 Mar 25
# modified : 2019 Mar 25
#

filepath=$(cd `dirname $0`; pwd)

brewcmd=$(which brew)

if [ -z $brewcmd ]; then
  echo "--------------------------"
  echo "Install brew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

zshcmd=$(which zsh)

if [ -z $zshcmd ]; then
  echo "--------------------------"
  echo "Install zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

cmd=$(which tmux) # tmux path
session=codefun   # session name

if [ -z $cmd ]; then
  echo "--------------------------"
  echo "Install tmux..."
  brew install tmux
fi

# git clone https://github.com/wangweicheng7/iterm-tumx-zsh.git

# # clone
# git clone https://github.com/powerline/fonts.git --depth=1
# # install
# cd fonts
# ./install.sh
# # clean-up a bit
# cd ..
# rm -rf fonts

# 拷贝资源文件
cd $filepath
# cp resource/pwzsh.zsh-theme ~/zsh_support/pwzsh.zsh-theme
# cp resource/tmux.conf ~/zsh_support/.tmux.conf
# cp resource/zshrc  ~/zsh_support/.zshrc

cp iterm-tumx-zsh/resource/pwzsh.zsh-theme ~/.oh-my-zsh/themes/pwzsh.zsh-theme
cp iterm-tumx-zsh/resource/tmux.conf ~/.tmux.conf
cp iterm-tumx-zsh/resource/zshrc  ~/.zshrc

rm -rf iterm-tumx-zsh

$cmd has -t $session

if [ $? != 0 ]; then
  $cmd new -d -n zsh -s $session "zsh" -s code
  $cmd splitw -h -p 50 -t $session "zsh"
  $cmd splitw -v -p 50 -t $session "zsh"
  # $cmd neww -n zsh -t $session "zsh"
  $cmd selectw -t $session:0
fi

$cmd att -t $session

exit 0