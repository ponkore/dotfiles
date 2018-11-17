#
# .bash_profile
#

[ -f $HOME/.bashrc ] && . $HOME/.bashrc

eval "$(pyenv init -)"
export PATH=$HOME/.local/bin:$PATH
