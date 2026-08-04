#!/usr/bin/env bash
set -u

PATH="/opt/homebrew/bin:$PATH"

payload=$(cat)
[ -n "$payload" ] || exit 0

prompt=$(printf '%s' "$payload" | jq -r '.prompt // empty' 2>/dev/null) || exit 0
cwd=$(printf '%s' "$payload" | jq -r '.cwd // empty' 2>/dev/null) || exit 0

review_invocation='^[[:space:]]*/(pawel-review|pr-review(:pr-review)?|review)([[:space:]]|$)'
[[ $prompt =~ $review_invocation ]] || exit 0

args=${prompt#*/}
args=${args#*[[:space:]]}

repo_flag=()
pr_number=""

if [[ $args =~ github\.com/([A-Za-z0-9._-]+)/([A-Za-z0-9._-]+)/pull/([0-9]+) ]]; then
  repo_flag=(-R "${BASH_REMATCH[1]}/${BASH_REMATCH[2]}")
  pr_number="${BASH_REMATCH[3]}"
elif [[ $args =~ ([A-Za-z0-9._-]+)/([A-Za-z0-9._-]+)#([0-9]+) ]]; then
  repo_flag=(-R "${BASH_REMATCH[1]}/${BASH_REMATCH[2]}")
  pr_number="${BASH_REMATCH[3]}"
elif [[ $args =~ (^|[[:space:]])#?([0-9]+)([[:space:]]|$) ]]; then
  pr_number="${BASH_REMATCH[2]}"
fi

[ -n "$pr_number" ] || exit 0

[ -d "$cwd" ] && cd "$cwd" 2>/dev/null

pr_json=$(gh pr view "$pr_number" "${repo_flag[@]+"${repo_flag[@]}"}" --json author,title,url 2>/dev/null) || exit 0
[ -n "$pr_json" ] || exit 0

author=$(printf '%s' "$pr_json" | jq -r '.author.login // empty')
repo=$(printf '%s' "$pr_json" | jq -r '.url // empty | split("/")[4] // empty')
pr_title=$(printf '%s' "$pr_json" | jq -r '.title // empty')

[ -n "$author" ] && [ -n "$repo" ] && [ -n "$pr_title" ] || exit 0

author=${author%-sb}

slug=$(printf '%s' "$pr_title" \
  | tr '[:upper:]' '[:lower:]' \
  | sed -e 's/[^a-z0-9]\{1,\}/-/g' -e 's/^-//' -e 's/-$//')

if [ ${#slug} -gt 50 ]; then
  slug=${slug:0:50}
  slug=${slug%-*}
fi

[ -n "$slug" ] || exit 0

title="$author · $repo · $slug"
if [ ${#title} -gt 200 ]; then
  title=${title:0:200}
fi

jq -cn --arg title "$title" \
  '{hookSpecificOutput: {hookEventName: "UserPromptSubmit", sessionTitle: $title}}'
