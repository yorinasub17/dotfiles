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

# NOTE: Must be using gsed
function rgsed() {
  local -r txtfind="$1"
  local -r replacewith="$2"
  local -r delim="${3:-|}"

  rg "$txtfind" --files-with-matches | xargs sed -e "s${delim}${txtfind}${delim}${replacewith}${delim}g" -I ''
}

function gitdefault() {
  local default_branch
  default_branch="$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')"
  # fallback if origin/HEAD is not set
  if [[ -z "$default_branch" ]]; then
    if git rev-parse --verify refs/remotes/origin/main >/dev/null 2>&1; then
      default_branch="main"
    elif git rev-parse --verify refs/remotes/origin/master >/dev/null 2>&1; then
      default_branch="master"
    else
      echo "gitdefault: cannot determine default branch" >&2
      return 1
    fi
  fi
  git switch "$default_branch"
}
