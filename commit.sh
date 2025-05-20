#!/bin/bash

# Files to randomly edit — make sure they exist
files=(
  "README.md"
  "main.go"
  "templates/index.html"
  "static/style.css"
)

# Commit messages pool (expand or customize)
messages=(
  "Fix typo in README"
  "Update configuration defaults"
  "Improve error handling"
  "Refactor helper function"
  "Adjust spacing for readability"
  "Add comments to clarify logic"
  "Optimize database query"
  "Remove unused imports"
  "Fix edge case bug"
  "Add logging for debugging"
  "Improve UI responsiveness"
  "Fix layout issue"
  "Enhance accessibility"
  "Update documentation"
  "Refactor for better maintainability"
  "Improve error messages"
  "Add unit tests"
  "Clean up code style"
  "Fix race condition"
  "Improve startup time"
)

# Generate random date/time in May 2019
random_date() {
  DAY=$(shuf -i 1-30 -n 1)
  HOUR=$(shuf -i 9-18 -n 1)
  MIN=$(shuf -i 0-59 -n 1)
  SEC=$(shuf -i 0-59 -n 1)
  echo "2019-05-$(printf "%02d" $DAY)T$(printf "%02d" $HOUR):$(printf "%02d" $MIN):$(printf "%02d" $SEC)"
}

# Random small code edits (add comment or tweak a line)
edit_file() {
  local file=$1
  # Append a comment line with commit note and random number to avoid exact duplicates
  echo "// Edit $(date +%s%N)" >>"$file"
}

for i in $(seq 1 300); do
  FILE="${files[$RANDOM % ${#files[@]}]}"
  MESSAGE="${messages[$RANDOM % ${#messages[@]}]}"
  DATE=$(random_date)

  # Make a tiny change
  edit_file "$FILE"

  # Stage and commit with fake date
  GIT_AUTHOR_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" git add "$FILE"
  GIT_AUTHOR_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" git commit -m "$MESSAGE"

  echo "Commit $i done: $MESSAGE at $DATE on $FILE"
done
