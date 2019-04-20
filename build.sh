#!/usr/bin/env bash
set -ex
cd $(dirname $0)
content_root="public"
content_output_root="_book"
pushd "$content_root"
# NOTE: don't use --root option
book sm
popd
# NOTE: you must run gitbook install at "$content_root" directory not current dir
gitbook build "$content_root" "$content_output_root"

github_io_repo_root="umaumax.github.io"
pushd "$github_io_repo_root"
git rm -r . | true
popd

# NOTE: ディレクトリごと
cp -R _layouts "$github_io_repo_root"
# NOTE: ファイルのみ
cp -r _book/ "$github_io_repo_root"
cp "$content_root"/README.md "$github_io_repo_root"
pushd "$github_io_repo_root"
git add .
git commit -m 'Update blog content' --no-verify
git push -u origin master
popd
git add "$github_io_repo_root"
git commit -m "Update $github_io_repo_root submodule" --no-verify
