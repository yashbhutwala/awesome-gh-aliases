#!/bin/bash

# https://news.ycombinator.com/item?id=10736584
set -o errexit -o nounset -o pipefail
# this line enables debugging
set -xv

################################################################################
# examples from https://cli.github.com/manual/gh_alias_set
gh alias set pv 'pr view'
gh alias set bugs 'issue list --label="bugs"'
gh alias set epicsBy 'issue list --author="$1" --label="epic"'
gh alias set --shell igrep 'gh issue list --label="$1" | grep -i $2'
################################################################################
#
################################################################################
# custom API
#
# user
gh alias set "user" 'api user'
#
# list-milestone
# '"'"' means a single single quote, see: https://stackoverflow.com/a/1250279
gh alias set --shell "list-milestones" 'gh api --paginate graphql -F owner='"'"':owner'"'"' -F name='"'"':repo'"'"' -f query='"'"'
    query($per_page: Int = 100, $endCursor: String, $name: String!, $owner: String!) {
      repository(owner: $owner, name: $name) {
        milestones(first: $per_page, after: $endCursor, states: OPEN, orderBy: {field:CREATED_AT, direction:DESC}) {
          nodes {
            title
            number
          }
          pageInfo {
            hasNextPage
            endCursor
          }
        }
      }
    }
  '"'"' | jq -r ".data.repository.milestones.nodes[] | [.number,.title] | @tsv"'
#
#

################################################################################


