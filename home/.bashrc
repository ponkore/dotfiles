#
# .bashrc
#

export LANG=ja_JP.UTF-8
export EDITOR=vim

###
if [ -f $HOME/.proxy-setting ]; then
    . $HOME/.proxy-setting
fi
###
[ -d /opt/local/bin ] && PATH=/opt/local/bin:$PATH
[ -d /opt/local/sbin ] && PATH=/opt/local/sbin:$PATH

###
[ -d /usr/local/bin ] && PATH=/usr/local/bin:$PATH
[ -d /usr/local/sbin ] && PATH=/usr/local/sbin:$PATH

case `uname` in
FreeBSD)
    # oracle environment
    # export ORACLE_BASE=/usr/lib/oracle/xe/app/oracle
    # export ORACLE_HOME=$ORACLE_BASE/product/10.2.0/server
    export ORACLE_HOME=~/Applications/Oracle/instantclient_10_2
    export PATH=$PATH:$ORACLE_HOME
    export NLS_LANG=JAPANESE_JAPAN.UTF8
    export PATH=$PATH:$ORACLE_HOME/bin
    export LD_LIBRARY_PATH=$ORACLE_HOME/lib
    alias sqlplus="LD_LIBRARY_PATH=$ORACLE_HOME sqlplus"
    export JAVA_VERSION=1.8
    ;;
Darwin)
    # oracle environment
    if [ -d ~/Applications/Oracle ]; then
        if [ -d ~/Applications/Oracle/instantclient_12_1 ]; then
            export ORACLE_HOME=~/Applications/Oracle/instantclient_12_1
        fi
        if [ -d ~/Applications/Oracle/instantclient_10_2 ]; then
            export ORACLE_HOME=~/Applications/Oracle/instantclient_10_2
        fi
        export DYLD_LIBRARY_PATH=$ORACLE_HOME
        export NLS_LANG=JAPANESE_JAPAN.UTF8
        export PATH=$PATH:$ORACLE_HOME
    fi
    export MANPATH=/opt/local/share/man:$MANPATH
    # for Postgres.app
    if [ -d /Applications/Postgres.app/Contents/Versions/latest/bin ]; then
        PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
    fi
    # for LightTable
    export LT_USER_DIR=~/.lighttable
    # rust
    if [ -d $HOME/.cargo/bin ]; then
        PATH=$PATH:$HOME/.cargo/bin
    fi
    PATH=$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin
    if [ -x /usr/libexec/path_helper ]; then
        eval $(/usr/libexec/path_helper -s)
    fi
    alias ls='exa'
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

    peco-select-history() {
        declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
        READLINE_LINE="$l"
        READLINE_POINT=${#l}
    }
    bind -x '"\C-r": peco-select-history'
fi

###
if [ -d $HOME/.npm ]; then
    export NODE_PATH=$HOME/.npm/libraries:$NODE_PATH
    export PATH=$HOME/.npm/bin:$PATH
    export MANPATH=$HOME/.npm/man:$MANPATH
fi

###
if [ -d $HOME/work/cloudbees-sdk-1.5.2 ]; then
    export BEES_HOME=$HOME/work/cloudbees-sdk-1.5.2
    export PATH=$PATH:$BEES_HOME
fi

###
if [ -d /usr/local/heroku/bin ]; then
    ### Added by the Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"
fi

###
[ -d $HOME/bin ] && PATH=$HOME/bin:$PATH

###
if [ -d $HOME/.go ]; then
    export GOPATH=$HOME/.go
    export PATH=$GOPATH/bin:$PATH
fi

###
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f $HOME/.nvm/versions/node/v9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . $HOME/.nvm/versions/node/v9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f $HOME/.nvm/versions/node/v9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . $HOME/.nvm/versions/node/v9.5.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/work/google-cloud-sdk/path.bash.inc' ]; then source '$HOME/work/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/work/google-cloud-sdk/completion.bash.inc' ]; then source '$HOME/work/google-cloud-sdk/completion.bash.inc'; fi

# aws cli command completion
complete -C '/usr/local/bin/aws_completer' aws

# hub command completion
[ -f $HOME/etc/hub.bash_completion.sh ] && . $HOME/etc/hub.bash_completion.sh
