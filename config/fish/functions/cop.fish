function cop -d 'runs rubocop with autocorrect'
  # Get a list of modified Ruby files
  set -l diff_files (git diff --name-only --diff-filter=d HEAD ^master | rg \.rb)

  # Exit if there are no files to check
  if not test -n "$diff_files"
    echo "No Ruby files to check."
    return
  end

  echo "Checking files:"
  echo $diff_files
  
  # Set arguments for RuboCop
  set -l rubocop_args
  if test -z "$argv"
    # Default to `-a` if no arguments were passed to the `cop` function
    set rubocop_args '-a'
  else
    # Otherwise, use the arguments that were provided
    set rubocop_args $argv
  end

  # Determine the execution command
  set -l image (cat .docker-exec-name 2>/dev/null)
  if test -n "$image"
    de rubocop $rubocop_args $diff_files
  else
    be rubocop $rubocop_args $diff_files
  end
end
