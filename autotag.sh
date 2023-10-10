#!/bin/bash
# Sergio Alías, 20230415
# Last modified 20231010

# autotag.sh
# Bash script for Git auto-tagging 

# Get the current tag, if any
last_tag=$(git describe --tags --abbrev=0 2>/dev/null)

if [ -z "$last_tag" ]; then
  # First commit: start with v1.0.0
  new_tag="v1.0.0"
else
  # Parse the last tag and increment the relevant part
  last_tag_parts=(${last_tag//./ })
  x=${last_tag_parts[0]:1}
  y=${last_tag_parts[1]}
  z=${last_tag_parts[2]}
  case $1 in
    -2)
      y=$((y+1))
      z=0
      ;;
    -1)
      x=$((x+1))
      y=0
      z=0
      ;;
    *)
      z=$((z+1))
      ;;
  esac
  new_tag="v${x}.${y}.${z}"
fi

# Get the last commit message
last_commit_msg=$(git log -1 --pretty=%B)

# Create the new tag and push it
git tag -a "$new_tag" -m "$last_commit_msg"
git push --tags

