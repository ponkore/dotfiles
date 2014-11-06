#
# .bash_profile
#

PS1='\u@\h\$ '

[ -d /opt/local/bin ] && PATH=/opt/local/bin:$PATH
[ -d /opt/local/sbin ] && PATH=/opt/local/sbin:$PATH

case `uname` in
FreeBSD|Darwin)
    alias ls='ls -CFGw'
    ;;
Linux|CYGWIN)
    alias ls='ls --color'
    ;;
esac

[ -f ~/.bashrc ] && . ~/.bashrc
