#! /usr/bin/env bash

note() {
  # Check if EDITOR is set
  if [ -z "$EDITOR" ]; then
    echo "The EDITOR environment variable is not set."
    exit 1
  fi

  # Define notes directory based on the current date
  BASE_DIR="$HOME/notes"
  NOTES_DIR=$(date +"%Y/%m")

  # Ensure the notes directory exists
  mkdir -p "${BASE_DIR}/${NOTES_DIR}"

  # Check for existing note files in the current date directory
  EXISTING_FILE=$(find "${BASE_DIR}/${NOTES_DIR}" -type f -printf "%T+ %p\n" | sort -r | head -n 1 | cut -d' ' -f2-)

  if [[ -n $EXISTING_FILE ]]; then
    # If an existing file is found, open it
    "$EDITOR" "$EXISTING_FILE"
  else
    # If no files are found, create a new file
    FILE=$(mktemp -u "${BASE_DIR}/${NOTES_DIR}/XXXXXXXXXXXXXXXXXXXX.md")
    "$EDITOR" "$FILE"
  fi
}

git_sync() {
  cd ~/notes || exit

  # Check if there are any changes.
  if [ -z "$(git status --porcelain)" ]; then
    echo "No changes to commit."
    return
  fi

  git add .
  git commit -m "$(mktemp -u XXXXXXXXXXXXXXXXXXXX)"
  git push origin main
  echo "OK"
}

case "$1" in
  push)
    git_sync
    ;;
  *)
    note
    ;;
esac
