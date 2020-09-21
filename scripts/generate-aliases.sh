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
# `gh user`: fetch information about the currently authenticated user as JSON
gh alias set 'user' 'api user'
#
# `gh list-milestones`: list the open milestones for the current repository
# NOTE: '"'"' means a single single quote, see: https://stackoverflow.com/a/1250279
gh alias set --shell 'list-milestones' \
  'gh api --paginate graphql -F owner='"'"':owner'"'"' -F name='"'"':repo'"'"' -f query='"'"'
      query($per_page: Int = 100, $endCursor: String, $owner: String!, $name: String!) {
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
# `PR_NUM=1 && gh pr-files-changed $PR_NUM`: lists files changed in pull request `$PR_NUM` for the current repository
gh alias set --shell 'pr-files-changed' \
  'gh api --paginate graphql -F owner='"'"':owner'"'"' -F name='"'"':repo'"'"' -F "pr=$1" -f query='"'"'
      query($per_page: Int = 100, $endCursor: String, $pr: Int!, $owner: String!, $name: String!) {
        repository(owner: $owner, name: $name) {
          pullRequest(number: $pr) {
            files(first: $per_page, after: $endCursor) {
              edges {
                node {
                  path
                }
              }
              pageInfo {
                endCursor
                hasNextPage
              }
            }
          }
        }
      }
    '"'"' | jq -r ".data.repository.pullRequest.files.edges[] | [.node.path] | @tsv"'
#
# `USER=yashbhutwala && gh list-repos $USER`: list repositories of `$USER`
gh alias set --shell 'list-repos' \
  'gh api --paginate graphql -F owner="$1" -f query='"'"'
      query($owner: String!, $per_page: Int = 100, $endCursor: String) {
        repositoryOwner(login: $owner) {
          repositories(first: $per_page, after: $endCursor, ownerAffiliations: OWNER) {
            nodes {
              nameWithOwner
            }
            pageInfo {
              hasNextPage
              endCursor
            }
          }
        }
      }
    '"'"' | jq -r ".data.repositoryOwner.repositories.nodes[] | [.nameWithOwner] | @tsv"'
################################################################################
#
# `N=10 QUERY=kubernetes && gh search-repos $N $QUERY` : List `$N` repositories and their stars count that match `$QUERY`
gh alias set --shell 'search-repos' \
  'gh api graphql -F per_page="$1" -F q="$2" -f query='"'"'
      query($q: String!, $per_page: Int = 10, $endCursor: String) {
        search(query: $q, type: REPOSITORY, first: $per_page, after: $endCursor) {
          nodes {
            ...on Repository {
              nameWithOwner
              stargazers {
                totalCount
              }
            }
          }
          pageInfo {
            hasNextPage
            endCursor
          }
        }
      }
    '"'"' | jq -r ".data.search.nodes[] | [.nameWithOwner,.stargazers.totalCount] | @tsv"'
