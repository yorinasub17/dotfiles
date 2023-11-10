export PATH="$HOME/.bin:$PATH"

function version_info() {
  local -r tool="$1"
  echo "$(asdf current "$tool")" | awk '{print $2}'
}

function unlock_bw() {
  local session_key
  session_key="$(bw unlock --raw)"
  export BW_SESSION="$session_key"
}

function example_load_secrets() {
  local -r item_id='aaaaaaaa-bbbb-bbbb-bbbb-aaaaaaaaaaaa'

  if [[ -z "${BW_SESSION}" ]]; then
    unlock_bw
  fi

  export SOME_SECRET="$(bw get item "$item_id" | jq -r '.login.password')"
  export SOME_SPECIAL_SECRET="$(echo "$item_id" | jq -r '.fields[] | select(.name == "Special Secret") | .value')"
}

function rgsed() {
  local -r txtfind="$1"
  local -r replacewith="$2"
  local -r delim="${3:-|}"

  rg "$txtfind" --files-with-matches | xargs sed -i "s${delim}${txtfind}${delim}${replacewith}${delim}g"
}
