#
# .bashrc
#
export LANG=ja_JP.UTF-8
export EDITOR=vim

##
[ -f $HOME/.proxy-setting ] && . $HOME/.proxy-setting

# path_helper (for macOS)
[ -x /usr/libexec/path_helper ] && eval $(/usr/libexec/path_helper -s)

##
[ -d $HOME/bin ] && PATH=$HOME/bin:$PATH
[ -d /usr/local/bin ] && PATH=/usr/local/bin:$PATH
[ -d /usr/local/sbin ] && PATH=/usr/local/sbin:$PATH

##
if [ -d $HOME/.pyenv ]; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
    fi
fi

##
if [ -d $HOME/.phpenv ]; then
    export PHPENV_ROOT="$HOME/.phpenv"
    export PATH="$PHPENV_ROOT/bin:$PATH"
    if command -v phpenv 1>/dev/null 2>&1; then
	eval "$(phpenv init -)"
    fi
fi

##
if [ -d $HOME/.rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
    export RUBYOPT=-W0
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
fi

##
if [ -d $HOME/.nvm ]; then
    export NVM_DIR=$HOME/.nvm
    [ -s $NVM_DIR/nvm.sh ] && . $NVM_DIR/nvm.sh  # This loads nvm
    [ -s $NVM_DIR/bash_completion ] && . $NVM_DIR/bash_completion  # This loads nvm bash_completion

    # tabtab source for serverless package
    # uninstall by removing these lines or running `tabtab uninstall serverless`
    NODE_VERSION=`cat $HOME/.nvm/alias/default`
    NODE_LIB_DIR=$HOME/.nvm/versions/node/$NODE_VERSION/lib
    SLS_COMPLETION_DIR=$NODE_LIB_DIR/node_modules/serverless/node_modules/tabtab/.completions
    if [ -d $SLS_COMPLETION_DIR ]; then
        [ -f $SLS_COMPLETION_DIR/serverless.bash ] && . $SLS_COMPLETION_DIR/serverless.bash
        # tabtab source for sls package
        # uninstall by removing these lines or running `tabtab uninstall sls`
        [ -f $SLS_COMPLETION_DIR/sls.bash ] && . $SLS_COMPLETION_DIR/sls.bash
    fi
    ##
    if [ -d $HOME/.npm ]; then
	export NODE_PATH=$HOME/.npm/libraries:$NODE_PATH
	export PATH=$HOME/.npm/bin:$PATH
	export MANPATH=$HOME/.npm/man:$MANPATH
    fi
fi
# windows environment nodejs
if [ -d "/c/Program Files/nodejs" ]; then
    PATH=$PATH:"/c/Program Files/nodejs"
fi
# windows environment for java11
if [ -d /c/Apps/pleiades/java/11 ]; then
    PATH=$PATH:/c/Apps/pleiades/java/11/bin
    unset CLASSPATH
fi
##
if [ -d $HOME/.sdkman ]; then
    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    export SDKMAN_DIR=$HOME/.sdkman
    [[ -s $SDKMAN_DIR/bin/sdkman-init.sh ]] && . $SDKMAN_DIR/bin/sdkman-init.sh
fi

# rust
[ -d $HOME/.cargo/bin ] && PATH=$PATH:$HOME/.cargo/bin

# roswell
[ -d $HOME/.roswell/bin ] && PATH=$PATH:$HOME/.roswell/bin

##
if [ -d $HOME/.go ]; then
    export GOPATH=$HOME/.go
    export PATH=$GOPATH/bin:$PATH
fi

case `uname` in
FreeBSD)
    # oracle environment
    if [ -d $HOME/Applications/Oracle ]; then
        # export ORACLE_BASE=/usr/lib/oracle/xe/app/oracle
        # export ORACLE_HOME=$ORACLE_BASE/product/10.2.0/server
        export ORACLE_HOME=$HOME/Applications/Oracle/instantclient_10_2
        export PATH=$PATH:$ORACLE_HOME
        export NLS_LANG=JAPANESE_JAPAN.UTF8
        export PATH=$PATH:$ORACLE_HOME/bin
        export LD_LIBRARY_PATH=$ORACLE_HOME/lib
        alias sqlplus="LD_LIBRARY_PATH=$ORACLE_HOME sqlplus"
    fi
    export JAVA_VERSION=1.8
    ;;
Darwin)
    # oracle environment
    if [ -d $HOME/Applications/Oracle ]; then
        if [ -d $HOME/Applications/Oracle/instantclient_12_1 ]; then
            export ORACLE_HOME=$HOME/Applications/Oracle/instantclient_12_1
        fi
        export DYLD_LIBRARY_PATH=$ORACLE_HOME
        export NLS_LANG=JAPANESE_JAPAN.UTF8
        export PATH=$PATH:$ORACLE_HOME
    fi
    # for Postgres.app
    [ -d /Applications/Postgres.app/Contents/Versions/latest/bin ] &&
        PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
    # mysql client
    [ -d /usr/local/opt/mysql-client/bin ] && PATH=$PATH:/usr/local/opt/mysql-client/bin
    # for LightTable
    [ -d $HOME/.lighttable ] && export LT_USER_DIR=$HOME/.lighttable
    ;;
Linux)
    export ORACLE_BASE=/opt/app/oracle
    export ORACLE_HOME=${ORACLE_BASE}/product/10.1.0/db_1
    export NLS_LANG=JAPANESE_JAPAN.JA16SJISTILDE
    export PATH=${PATH}:${ORACLE_HOME}/bin
    alias sqlplus='NLS_LANG=JAPANESE_JAPAN.UTF8 sqlplus $*'
    alias lsnrctl='NLS_LANG=JAPANESE_JAPAN.UTF8 lsnrctl $*'
    ;;
MSYS_*|MINGW*)
    [ -d /c/Apps/bin ] && PATH=$PATH:/c/Apps/bin
    [ x$TERM == xscreen ] && TERM=xterm
    alias ls='ls --color'
    [ -d $HOME/.gem ] && PATH=$PATH:$HOME/.gem/ruby/2.4.0/bin
    ;;
esac

# bash completion
if [[ $PS1 ]]; then
    # macOS
    [ -f /usr/local/etc/bash_completion ] && \
	. /usr/local/etc/bash_completion
    # FreeBSD
    [ -f /usr/local/share/bash-completion/bash_completion.sh ] && \
	. /usr/local/share/bash-completion/bash_completion.sh
fi

##
if [ ! -z "$PS1" ]; then
    PS1="\[\e]0;\w\a\]\[\e[32m\]\u@\h\[\e[0m\]\$ "
    if [ -z "$INSIDE_EMACS" ]; then
        peco-select-history() {
            declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
            READLINE_LINE="$l"
            READLINE_POINT=${#l}
        }
        bind -x '"\C-r": peco-select-history'
    fi
fi

## for tmux
export TMUX_TMPDIR=/tmp/tmp.tmux
[ ! -d $TMUX_TMPDIR ] && mkdir -m700 $TMUX_TMPDIR

##
if [ -f $HOME/.git-prompt.sh ]; then
    . $HOME/.git-prompt.sh
    # export PS1='\u@\h \W$(__git_ps1 " (%s)")\$ '
    export PS1='\u@\h \[\033[32m\]\w\[\033[33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
    function cd () { builtin cd "$@" && printf "\033]0;$(__git_ps1 '%s')\007"; }
    function checkout () { git checkout "$@" && printf "\033]0;$(__git_ps1 '%s')\007"; }
fi

## Added by the Heroku Toolbelt
[ -d /usr/local/heroku/bin ] && export PATH="/usr/local/heroku/bin:$PATH"

# Google Cloud SDK
GCLOUD_DIR=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
if [ -d $GCLOUD_DIR ]; then
    # The next line updates PATH for the Google Cloud SDK.
    [ -f $GCLOUD_DIR/path.bash.inc ] && . $GCLOUD_DIR/path.bash.inc

    # The next line enables shell command completion for gcloud.
    [ -f $GCLOUD_DIR/completion.bash.inc ] && . $GCLOUD_DIR/completion.bash.inc
fi

# aws cli command completion
[ -f /usr/local/bin/aws_completer ] && complete -C /usr/local/bin/aws_completer aws

# hub command completion
[ -f $HOME/etc/hub.bash_completion.sh ] && . $HOME/etc/hub.bash_completion.sh

# aliases
command -v exa   1>/dev/null 2>&1 && alias ls='exa'
command -v rg    1>/dev/null 2>&1 && alias rg='rg -p'
command -v less  1>/dev/null 2>&1 && alias less='less -R'
command -v bat   1>/dev/null 2>&1 && alias cat='bat'
command -v mysql 1>/dev/null 2>&1 && alias mysql='mysql -h 127.0.0.1 -u root -p'
command -v psql  1>/dev/null 2>&1 && alias psql='psql -U postgres -h 127.0.0.1 fwdssdb --password'
command -v vim   1>/dev/null 2>&1 && alias vi='vim'
command -v lein  1>/dev/null 2>&1 && alias lein='LEIN_USE_BOOTCLASSPATH=no lein'

# docker command alias
alias dphp='docker exec -w /home/fwdss/fwdsalessupport -it v1_develop_fwdss_websv_dev_1 php $*'
alias dphpunit='docker exec -w /home/fwdss/fwdsalessupport -it v1_develop_fwdss_websv_dev_1 php vendor/bin/phpun it $*'

# jdk path (for macOS)
[ -x /usr/libexec/java_home ] && PATH=$PATH:"$(/usr/libexec/java_home)"/bin

# flutter sdk
[ -d $HOME/Applications/flutter ] && PATH=$PATH:$HOME/Applications/flutter/bin

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true

[ -d ~/Library/Android/sdk/platform-tools ] && PATH=~/Library/Android/sdk/platform-tools:$PATH
[ -d ~/Library/Android/sdk/ndk/21.3.6528147 ] && PATH=~/Library/Android/sdk/ndk/21.3.6528147:$PATH
