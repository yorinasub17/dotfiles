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
    _1LEFT="%F{blue}[%n]%f %F{yellow}%~%f %F{cyan}$(git_prompt_info)%f"
    _1RIGHT="%F{magenta}[go:%B$(version_info golang)%b][njs:%B$(version_info nodejs)%b][tf:%B$(version_info terraform)%b]%f"
    _1SPACES=`get_space $_1LEFT $_1RIGHT`
    print
    print -rP "$_1LEFT$_1SPACES$_1RIGHT"
}


PROMPT='%F{red}%#~>%f '
RPROMPT='%F{red}[%?]%f'
autoload -U add-zsh-hook
add-zsh-hook precmd yori_precmd
