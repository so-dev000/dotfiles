alias python='python3'
source ~/.zsh/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f: %F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f$ '
eval "$(direnv hook zsh)"

alias ojt='oj t -c "python main.py" -d test'
alias accs='acc s -- main.py --language 5078'
eval "$(rbenv init -)"
export PATH="$HOME/.gem/ruby/*/bin:$PATH"
eval `opam config env`

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias miniml='cat | dune exec miniml'


export SUPPRESS_CRASH_REPORT=1

alias rails-s='rails assets:clobber && rails assets:precompile && rails s'


if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi


source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(direnv hook zsh)"

# ============================================
# Git AI Review Aliases
# ============================================
alias git-review='~/.git-hooks/ai-review.sh'
alias git-review-status='~/.git-hooks/review-status.sh'

# Add ~/bin to PATH for custom git commands
export PATH="$HOME/bin:$PATH"

# Created by `pipx` on 2025-10-17 14:41:23
export PATH="$PATH:$HOME/.local/bin"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section

alias mkpyrightconf='printf "{\n  \"diagnosticMode\": \"off\",\n  \"typeCheckingMode\": \"off\"\n}\n" > pyrightconfig.json'
eval "$(~/.local/bin/mise activate)"
export PATH=$PATH:~/roc_nightly-macos_apple_silicon-2025-09-09-d73ea109cc2

# LaTeX compile function (with Skim for scroll position preservation)
compile-tex() {
    if [ -z "$1" ]; then
        echo "Usage: compile-tex <filename without .tex>"
        return 1
    fi

    local filename="${1%.tex}"  # Remove .tex extension if provided

    platex -synctex=1 "${filename}.tex" && \
    platex -synctex=1 "${filename}.tex" && \
    dvipdfmx "${filename}.dvi" && \
    open -g -a Skim "${filename}.pdf"
}

# LaTeX continuous compile function (auto-recompile on file change)
watch-tex() {
    if [ -z "$1" ]; then
        echo "Usage: watch-tex <filename without .tex>"
        return 1
    fi

    local filename="${1%.tex}"  # Remove .tex extension if provided

    echo "Watching ${filename}.tex for changes..."
    echo "Press Ctrl+C to stop"
    latexmk -pvc "${filename}.tex"
}

export GPG_TTY=$(tty)

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
