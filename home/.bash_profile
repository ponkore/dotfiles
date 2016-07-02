#
# .bash_profile
#

case `uname` in
FreeBSD|Darwin)
    alias ls='ls -CFGw'
    ;;
Linux*|CYGWIN*|MINGW*)
    alias ls='ls --color'
    ;;
esac

if [ ! -z "$PS1" ]; then
    PS1="\[\e]0;\w\a\]\[\e[32m\]\u@\h\[\e[0m\]\$ "

    peco-select-history() {
        declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
        READLINE_LINE="$l"
        READLINE_POINT=${#l}
    }
    bind -x '"\C-r": peco-select-history'
fi

[ -f $HOME/.bashrc ] && . $HOME/.bashrc
