#
# .bash_profile
#

PS1='\u@\h\$ '

case `uname` in
FreeBSD|Darwin)
	alias ls='ls -CFGw'
	;;
Linux|CYGWIN)
	alias ls='ls --color'
	;;
esac

[ -f ~/.bashrc ] && . ~/.bashrc
