# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' check-for-changes true

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b %u%c%m)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c%m)'
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='?'
    fi
}

function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # Exit early in case the worktree is on a detached HEAD
    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    local -a ahead_and_behind=(
        $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

    if [[ "${ahead}" == "0" && ${behind} == "0" ]] then
        gitstatus+=()
    elif [[ ${ahead} > "0" && ${behind} == "0" ]] then
        gitstatus+=( " +${ahead}" )
    elif [[ ${behind} > "0" && $ahead == "0" ]] then
        gitstatus+=( " -${behind}" )
    else
        gitstatus+=(" +${ahead}-${behind}")
    fi

    hook_com[misc]+=${(j:/:)gitstatus}
}

alias ls="ls --color=auto"
export LEDGER_FILE=~/repos/finance/2021/2021-all.journal
export EDITOR=nvim
export TERM=alacritty
TERM="xterm-256color"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

PROMPT='%F{green}%n%f%F{green}@%f%F{green}%m%f%f%F{red}${vcs_info_msg_0_}%f:%F{blue}%~ %F{white}'
eval "$(direnv hook zsh)"
eval $(keychain --eval --quiet id_ed25519)

export QSYS_ROOTDIR="/home/spencer/.cache/paru/clone/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/20.1/quartus/sopc_builder/bin"
