<!-- omit in toc -->
# awesome-gh-aliases

A curated aliases and api scripts for GitHub's official command line tool [gh](https://github.com/cli/cli).  Essentially, a collection of useful combinations of [gh api](https://cli.github.com/manual/gh_api) and [gh alias](https://cli.github.com/manual/gh_alias)!

<!-- omit in toc -->
## Table of Contents

- [Script to generate the aliases](#script-to-generate-the-aliases)
- [Starter config](#starter-config)
- [Usage](#usage)
- [Similar projects](#similar-projects)

## Script to generate the aliases

```bash
./scripts/generate-aliases.sh
```

## Starter config

```bash
# backup your existing config
cp $HOME/.config/gh/config.yml{,.bak}
# copy the config from this repo to your gh folder
cp config.yml $HOME/.config/gh/config.yml
```

## Usage

- `gh user`: fetch information about the currently authenticated user as JSON
- `gh list-milestones`: list the open milestones for the current repository
- `PR_NUM=1 && gh pr-files-changed $PR_NUM`: lists files changed in pull request `$PR_NUM` for the current repository
- `USER=yashbhutwala && gh list-repos $USER`: list repositories of `$USER`
- `N=10 QUERY=kubernetes && gh search-repos $N $QUERY` : List `$N` repositories and their stars count that match `$QUERY`

## Similar projects

[mislav/hub-api-utils](https://github.com/mislav/hub-api-utils) is an inspiration for this project.
