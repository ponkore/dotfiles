#
# .profile
#

export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:$PATH
export LANG=ja_JP.UTF-8
export EDITOR=vim

case `uname` in
FreeBSD)
	# export MANPATH=/opt/local/share/man:$MANPATH
	# oracle environment
	export ORACLE_BASE=/usr/lib/oracle/xe/app/oracle
	export ORACLE_HOME=$ORACLE_BASE/product/10.2.0/server
	export NLS_LANG=JAPANESE_JAPAN.UTF8
	export PATH=$PATH:$ORACLE_HOME/bin
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib
	export ORACLE_SID=MYDB
	;;
Darwin)
	export MANPATH=/opt/local/share/man:$MANPATH
	#export JAVA_HOME='/System/Library/Frameworks/JavaVM.framework/Home'
	#export JAVA_HOME='/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home'
	#export JRUBY_HOME=$HOME/jruby
	#export PATH=$JAVA_HOME/bin:$PATH
	#export PATH=$JRUBY_HOME/bin:$PATH
	#export PATH=$PATH:/opt/local/lib/postgresql83/bin
	# oracle environment
	# set in environment.plist
	#export ORACLE_HOME=$HOME/oracle/ohome
	#export NLS_LANG=JAPANESE_JAPAN.UTF8
	#export PATH=$PATH:$ORACLE_HOME/bin
	#export DYLD_LIBRARY_PATH=$ORACLE_HOME/lib

	#export SVNROOT=/opt/local/var/SVN/myrepository

	#export HTTP_PROXY=http://172.23.1.10:8080
	#export http_proxy=http://172.23.1.10:8080
	#export RSYNC_PROXY=172.23.1.10:8080
	#export GIT_PROXY_COMMAND=~/bin/git-proxy

	export NODE_PATH=$HOME/.npm/libraries:$NODE_PATH
	export PATH=$HOME/.npm/bin:$PATH
	export MANPATH=$HOME/.npm/man:$MANPATH
	;;
CYGWIN*)
	export PATH=/cygdrive/c/Apps/bin:/cygdrive/c/Apps/ruby/bin:$PATH
	;;
esac

###
export BEES_HOME=~/work/cloudbees-sdk-1.5.2
export PATH=$PATH:$BEES_HOME

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
