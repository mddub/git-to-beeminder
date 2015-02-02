#!/bin/bash
#
# Update Beeminder (optionally) whenever you commit to a local git repo.
#
# `source` this script from a post-commit hook, and ensure the following
# environment variables are set:
#
# $BEEMINDER_USERNAME
# $BEEMINDER_GOAL (i.e. the goal's url slug)
# $BEEMINDER_AUTH_TOKEN (find this in advanced settings)
#
# Optionally:
# $BEEMINDER_MESSAGE_PREFIX (a string prepended to the datapoint's message)

set -e

function submit_to_beeminder {
    echo "Posting to Beeminder..."
    curl https://www.beeminder.com/api/v1/users/$BEEMINDER_USERNAME/goals/$BEEMINDER_GOAL/datapoints.json \
        --data "auth_token=$BEEMINDER_AUTH_TOKEN" \
        --data "value=1" \
        --data-urlencode "comment=$BEEMINDER_MESSAGE_PREFIX$commit_message"
    echo ""
}

function prompt {
    local commit_message=$(git log -1 --pretty=%B)
    local truncated=$([ "${#commit_message}" -le "30" ] && echo "$commit_message" || echo ${commit_message::27}"...")

    read -r -p "Post this commit (\"$BEEMINDER_MESSAGE_PREFIX$truncated\") to Beeminder goal \"$BEEMINDER_GOAL\"? [y/n] " response

    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        submit_to_beeminder
    else
        echo "Skipped posting to Beeminder."
    fi
}

# Assign stdin to keyboard so we can read user input
# (post-commit hook is not run in an interactive environment)
exec < /dev/tty

# Don't prompt if a rebase is in progress
if [ ! -d "$(git rev-parse --show-toplevel)/.git/rebase-merge" ]; then
    prompt
fi

# Close stdin
exec <&-
