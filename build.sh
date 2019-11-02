#!/usr/bin/env bash
set -ex
cd $(dirname $0)
content_root="public"
content_output_root="_book_tmp"
github_io_repo_root="umaumax.github.io"

pushd "$content_root"
# NOTE: don't use --root option
book sm
popd

# NOTE: you must run gitbook install at "$content_root" directory not current dir
gitbook build "$content_root" "$content_output_root"

pushd "$github_io_repo_root"
git rm -r . | true
popd

# NOTE: whole directory
cp -R _layouts "$github_io_repo_root"
# NOTE: only files
cp -r "$content_output_root"/ "$github_io_repo_root"
rm -rf "$content_output_root"
cp "$content_root"/README.md "$github_io_repo_root"
