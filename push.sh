#!/usr/bin/env bash
set -ex
cd $(dirname $0)
content_root="public"
content_output_root="_book_tmp"
github_io_repo_root="umaumax.github.io"

pushd "$github_io_repo_root"
git add .
git commit -m 'Update blog content' --no-verify
git push -u origin master
popd

git add "$github_io_repo_root"
git commit -m "Update $github_io_repo_root submodule" --no-verify
git add "$content_root/SUMMARY.md"
git commit -m "Update SUMMARY.md" --no-verify
