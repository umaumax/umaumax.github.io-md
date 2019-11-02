#!/usr/bin/env bash
set -eu

BLACK=$'\e[30m' RED=$'\e[31m' GREEN=$'\e[32m' YELLOW=$'\e[33m' BLUE=$'\e[34m' PURPLE=$'\e[35m' LIGHT_BLUE=$'\e[36m' WHITE=$'\e[37m' GRAY=$'\e[90m' DEFAULT=$'\e[0m'

cd $(dirname $0)

echo "${YELLOW}[LOG] git status${DEFAULT}"
git status

submodule_path='./umaumax.github.io'
git_repo_dir="$PWD/$submodule_path"
dot_git_dir="$PWD/$submodule_path/.git"
echo "${YELLOW}[LOG] $submodule_path git status${DEFAULT}"
git --git-dir "$dot_git_dir" -C "$git_repo_dir" status
