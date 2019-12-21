# umaumax.github.io

[umaumax.github.io]( https://umaumax.github.io/ )

## TODO
* 他の記事に移動する際に，コードハイライト機能を有効にするためにはリロードをしなくてはならない問題の解決
* gitbook buildをしたときに，左側のメニューになぜかBookと新規追加したファイル?のリストが現れる問題
* google analytics

## init
```
git submodule update --init --recursive
```

## how to update this blog (only for me)
```
# pgrep -lf gitbook and if not exist
# ./daemon.sh or ./serve.sh
# access to localhost:4000 or localhost:4001
# to update
./build.sh
./push.sh
```

## local server
* rootに`README.md`が必要
  * > FileNotFoundError: No "README" file (or is ignored)
  * このときの索引は`SUMMARY.md`をもとに自動生成される
  * また，`SUMMARY.md`のlink先はあくまでも`*.md`となっている

## remote server(at github.io)
* 内部構成はhtml形式

## FMI
[GitHub Pagesで反映されないページをすぐに反映させる方法 \- Qiita]( https://qiita.com/shge/items/ac20f45c9e8e0b4f33cc )

----

## FYI
### hugo
* pros
* cons
  * default no search function

[Hugo に全文検索を取り付けた \| the right stuff]( http://rs.luminousspice.com/hugo-site-search/ )
[HUGOテーマ\(pulp\)に全文検索機能を付けた \- Kazuki Koide]( https://koirand.github.io/blog/2018/pulp-search/ )

### jekyll
* pros
* cons
  * default no search function

[サイト内検索を自由にカスタマイズ！Jekyllに全文検索を追加する「jekyll\-lunr\-js\-search」 \- Yohei Isokawa]( https://blog.yuhiisk.com/archive/2016/01/03/jekyll-full-text-search.html )

### hexo
* pros
* cons
  * default no search function
  * 生成が遅い?

[Hexoで構築したサイトに検索機能を実装したい \- YoshinoriN's Memento]( https://yoshinorin.net/2018/11/15/implement-search-feature-to-hexo/ )

### Pelican
* pros
* cons
  * default no search function

### gitbook
* pros
  * defaultで全文検索機能が使える(title and content)
* cons
  * 目次の項目で英語が大文字始まりになってしまう -> pluginで設定の変更可能
