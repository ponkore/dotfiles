#
# .bashrc
#

export LANG=ja_JP.UTF-8
export EDITOR=vim

###
[ -d /opt/local/bin ] && PATH=/opt/local/bin:$PATH
[ -d /opt/local/sbin ] && PATH=/opt/local/sbin:$PATH

###
[ -d /usr/local/bin ] && PATH=/usr/local/bin:$PATH
[ -d /usr/local/sbin ] && PATH=/usr/local/sbin:$PATH

case `uname` in
FreeBSD)
	# oracle environment
	export ORACLE_BASE=/usr/lib/oracle/xe/app/oracle
	export ORACLE_HOME=$ORACLE_BASE/product/10.2.0/server
	export NLS_LANG=JAPANESE_JAPAN.UTF8
	export PATH=$PATH:$ORACLE_HOME/bin
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib
	export ORACLE_SID=MYDB
	;;
Darwin)
	# oracle environment
	export ORACLE_HOME=$HOME/Application/Oracle/instantclient_10.2
	export DYLD_LIBRARY_PATH=$ORACLE_HOME
	export NLS_LANG=JAPANESE_JAPAN.UTF8
	export PATH=$PATH:$ORACLE_HOME
	export MANPATH=/opt/local/share/man:$MANPATH
	;;
Linux)
	;;
CYGWIN)
	export PATH=/cygdrive/c/Apps/bin:/cygdrive/c/Apps/ruby/bin:$PATH
	;;
esac

###
if [ -f ~/.proxy-setting ]; then
	. ~/.proxy-setting
fi

###
if [ -d ~/.npm ]; then
	export NODE_PATH=$HOME/.npm/libraries:$NODE_PATH
	export PATH=$HOME/.npm/bin:$PATH
	export MANPATH=$HOME/.npm/man:$MANPATH
fi

###
if [ -d ~/work/cloudbees-sdk-1.5.2 ]; then
	export BEES_HOME=~/work/cloudbees-sdk-1.5.2
	export PATH=$PATH:$BEES_HOME
fi

###
if [ -d /usr/local/heroku/bin ]; then
	### Added by the Heroku Toolbelt
	export PATH="/usr/local/heroku/bin:$PATH"
fi

###
[ -d ~/bin ] && PATH=~/bin:$PATH
