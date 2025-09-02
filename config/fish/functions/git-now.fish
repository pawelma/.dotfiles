function git-now -d "sets the last commit date to current"
  env GIT_COMMITTER_DATE=(date) git commit --amend --no-edit --date (date)
end
