# umaumax.github.io

[umaumax.github.io]( https://umaumax.github.io/ )

## TODO
* 他の記事に移動する際に，コードハイライト機能を有効にするためにはリロードをしなくてはならない問題の解決
* gitbook buildをしたときに，左側のメニューになぜかBookと新規追加したファイル?のリストが現れる問題
* google analytics

## how to update this blog (only for me)
```
# pgrep -lf gitbook and if not exist
# ./daemon.sh or ./serve.sh
# access to localhost:4000
# to update
./build.sh
```

## local server
* rootに`README.md`が必要
  * > FileNotFoundError: No "README" file (or is ignored)
  * このときの索引は`SUMMARY.md`をもとに自動生成される
  * また，`SUMMARY.md`のlink先はあくまでも`*.md`となっている

## remote server(at github.io)
* 内部構成はhtml形式
