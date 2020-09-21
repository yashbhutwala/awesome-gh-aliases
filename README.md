<!-- omit in toc -->
# awesome-gh-aliases

A curated aliases and api scripts for GitHub's official command line tool [gh](https://github.com/cli/cli).  Essentially, a collection of useful combinations of [gh api](https://cli.github.com/manual/gh_api) and [gh alias](https://cli.github.com/manual/gh_alias)!

<!-- omit in toc -->
## Table of Contents

- [Script to generate the aliases](#script-to-generate-the-aliases)
- [Starter config to copy](#starter-config-to-copy)

## Script to generate the aliases

```bash
./scripts/generate-aliases.sh
```

## Starter config to copy

```bash
# backup your existing config
cp $HOME/.config/gh/config.yml{,.bak}
# copy the config from this repo to your gh folder
cp config.yml $HOME/.config/gh/config.yml
```
