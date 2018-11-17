#
# .bashrc
#

export LANG=ja_JP.UTF-8
export EDITOR=vim

##
[ -f $HOME/.proxy-setting ] && . $HOME/.proxy-setting

##
[ -d ~/bin ] && PATH=~/bin:$PATH
[ -d /usr/local/bin ] && PATH=/usr/local/bin:$PATH
[ -d /usr/local/sbin ] && PATH=/usr/local/sbin:$PATH

case `uname` in
FreeBSD)
    # oracle environment
    if [ -d ~/Applications/Oracle ]; then
        # export ORACLE_BASE=/usr/lib/oracle/xe/app/oracle
        # export ORACLE_HOME=$ORACLE_BASE/product/10.2.0/server
        export ORACLE_HOME=~/Applications/Oracle/instantclient_10_2
        export PATH=$PATH:$ORACLE_HOME
        export NLS_LANG=JAPANESE_JAPAN.UTF8
        export PATH=$PATH:$ORACLE_HOME/bin
        export LD_LIBRARY_PATH=$ORACLE_HOME/lib
        alias sqlplus="LD_LIBRARY_PATH=$ORACLE_HOME sqlplus"
    fi
    export JAVA_VERSION=1.8
    alias rg='rg -p'
    alias less='less -R'
    alias cat='bat'
    alias mysql='mysql -h 127.0.0.1 -D ideapdb -u root -p'
    alias psql='psql -U ideap --password ideap'
    ;;
Darwin)
    # oracle environment
    if [ -d ~/Applications/Oracle ]; then
        if [ -d ~/Applications/Oracle/instantclient_12_1 ]; then
            export ORACLE_HOME=~/Applications/Oracle/instantclient_12_1
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
    [ -d ~/.lighttable ] && export LT_USER_DIR=~/.lighttable
    # rust
    [ -d $HOME/.cargo/bin ] && PATH=$PATH:$HOME/.cargo/bin
    # roswell
    [ -d $HOME/.roswell/bin ] && PATH=$PATH:$HOME/.roswell/bin
    # path_helper
    [ -x /usr/libexec/path_helper ] && eval $(/usr/libexec/path_helper -s)

    alias ls='exa'
    alias rg='rg -p'
    alias less='less -R'
    alias cat='bat'
    alias mysql='mysql -h 127.0.0.1 -D ideapdb -u root -p'
    alias psql='psql -U ideap --password ideap'
    ;;
Linux)
    export ORACLE_BASE=/opt/app/oracle
    export ORACLE_HOME=${ORACLE_BASE}/product/10.1.0/db_1
    export NLS_LANG=JAPANESE_JAPAN.JA16SJISTILDE
    export PATH=${PATH}:${ORACLE_HOME}/bin
    alias sqlplus='NLS_LANG=JAPANESE_JAPAN.UTF8 sqlplus $*'
    alias lsnrctl='NLS_LANG=JAPANESE_JAPAN.UTF8 lsnrctl $*'
    ;;
CYGWIN*)
    export PATH=/cygdrive/c/Apps/bin:/cygdrive/c/Apps/ruby/bin:$PATH
    export PS1='\h$ '
    ;;
MSYS_*|MINGW*)
    export MSYSTEM=MINGW32
    export PATH=/c/Apps/msys32/usr/bin:$PATH
    PS1='\h$ '
    ;;
esac

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

##
if [ -f ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
    # export PS1='\u@\h \W$(__git_ps1 " (%s)")\$ '
    export PS1='\u@\h \[\033[32m\]\w\[\033[33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
    function cd () { builtin cd "$@" && printf "\033]0;$(__git_ps1 '%s')\007"; }
    function checkout () { git checkout "$@" && printf "\033]0;$(__git_ps1 '%s')\007"; }
fi

##
if [ -d $HOME/work/cloudbees-sdk-1.5.2 ]; then
    export BEES_HOME=$HOME/work/cloudbees-sdk-1.5.2
    export PATH=$PATH:$BEES_HOME
fi

## Added by the Heroku Toolbelt
[ -d /usr/local/heroku/bin ] && export PATH="/usr/local/heroku/bin:$PATH"

##
if [ -d $HOME/.go ]; then
    export GOPATH=$HOME/.go
    export PATH=$GOPATH/bin:$PATH
fi

##
if [ -d ~/.npm ]; then
    export NODE_PATH=~/.npm/libraries:$NODE_PATH
    export PATH=~/.npm/bin:$PATH
    export MANPATH=~/.npm/man:$MANPATH
fi

##
if [ -d ~/.nvm ]; then
    export NVM_DIR=~/.nvm
    [ -s $NVM_DIR/nvm.sh ] && . $NVM_DIR/nvm.sh  # This loads nvm

    # tabtab source for serverless package
    # uninstall by removing these lines or running `tabtab uninstall serverless`
    NODE_VERSION=`cat ~/.nvm/alias/default`
    NODE_LIB_DIR=~/.nvm/versions/node/$NODE_VERSION/lib
    SLS_COMPLETION_DIR=$NODE_LIB_DIR/node_modules/serverless/node_modules/tabtab/.completions
    if [ -d $SLS_COMPLETION_DIR ]; then
        [ -f $SLS_COMPLETION_DIR/serverless.bash ] && . $SLS_COMPLETION_DIR/serverless.bash
        # tabtab source for sls package
        # uninstall by removing these lines or running `tabtab uninstall sls`
        [ -f $SLS_COMPLETION_DIR/sls.bash ] && . $SLS_COMPLETION_DIR/sls.bash
    fi
fi

##
if [ -d ~/.sdkman ]; then
    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    export SDKMAN_DIR=~/.sdkman
    [[ -s $SDKMAN_DIR/bin/sdkman-init.sh ]] && . $SDKMAN_DIR/bin/sdkman-init.sh
fi

GCLOUD_DIR=~/work/google-cloud-sdk
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
