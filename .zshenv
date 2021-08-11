export PATH="$HOME/.bin:$PATH"

function version_info() {
  local -r tool="$1"
  echo "$(asdf current "$tool")" | awk '{print $2}'
}
