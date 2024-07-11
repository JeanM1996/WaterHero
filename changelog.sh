#!/bin/bash

# Set the output file path
output_file="CHANGELOG.md"

# Get the list of git tags and order by version number
tags=$(git tag --sort=-v:refname)

# Initialize the changelog
changelog="# CHANGELOG GESTION FINANCIERA\n=========\n\n"

# Loop through each git tag
for tag in $tags; do
  # Get the commit logs between the current and previous tags
  previous_tag=$(git describe --tags --abbrev=0 $tag^)
  logs=$(git log $previous_tag..$tag --pretty=format:"%s")

  # Add the version and release date to the changelog exclude the words tag and Tagger:
  release_date=$(git log -1 --pretty=format:"%ad" --date=short $tag)
  changelog+="## [$tag] - $release_date\n"

  # Loop through each commit log
  while IFS= read -r log; do
    # Get the commit type from message
    commit_type=$(echo $log | cut -d':' -f1)


    commit_msg=$(echo $log | cut -d')' -f2)

    # Add the commit message to the changelog under the corresponding section
    case $commit_type in
      feat)
        section="### Added";;
      fix)
        section="### Fixed";;
      chore)
        section="### Miscellaneous";;
      docs)
        section="### Documentation";;
      style)
        section="### Style Changes";;
      *)
        section="### Miscellaneous";;
    esac

    changelog+="\n$section\n- $commit_msg"
  done <<< "$logs"
  changelog+="\n"
done

# Check if there are no changes
if [[ -z "$changelog" ]]; then
  echo "No changes found."
  exit 0
fi

# Prepend the changelog to the output file
echo -e "$changelog\n$(cat $output_file)" > $output_file

echo "Changelog generated to $output_file."
