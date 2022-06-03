alias tm='ps auxf | sort -nr -k 4 | head -10'
alias tc='ps auxf | sort -nr -k 3 | head -10'
alias fm='free -m -l -t'
alias grep='grep --color=auto'
alias cd..='cd ..'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gc='git clone'
alias sudo='/usr/bin/sudo'
alias u='/usr/bin/sudo -i -u root'
alias l.='ls -dG .*'
alias la='ls -GFlash'
alias ll='ls -GFlsh'
alias ls='ls -GF'

if command -v vim >/dev/null 2>&1; then
  alias vi='vim'
fi

export HISTTIMEFORMAT='&F &T '