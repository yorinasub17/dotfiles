get_space () {
  local STR=$1$2
  local zero='%([BSUbfksu]|([FB]|){*})'
  local LENGTH=${#${(S%%)STR//$~zero/}}
  local SPACES=""
  (( LENGTH = ${COLUMNS} - $LENGTH - 1))

  for i in {0..$LENGTH}
    do
      SPACES="$SPACES "
    done

  echo $SPACES
}


yori_precmd() {
    _1LEFT="%F{blue}[%n@%m]%f %F{yellow}%~%f %F{cyan}$(git_prompt_info)%f"
    _1RIGHT="%F{magenta}[hstn:%B$(hstn_prompt_info)%b][tf:%B$(tfenv_prompt_info)%b][py:%B$(pyenv_prompt_info)%b][njs:%B$(nvm_prompt_info)%b][rb:%B$(rbenv_prompt_info_works)%b]%f"
    _1SPACES=`get_space $_1LEFT $_1RIGHT`
    print
    print -rP "$_1LEFT$_1SPACES$_1RIGHT"
}


PROMPT='%F{red}%#~>%f '
RPROMPT='%F{red}[%?]%f'
autoload -U add-zsh-hook
add-zsh-hook precmd yori_precmd
