# shared library

## xxx: error while loading shared libraries: yyy
* [Linux: ライブラリの動的リンクでエラーが出た場合の対処方法]( https://leico.github.io/TechnicalNote/Linux/ld-library-path )
* [\(6\) ldconfigでライブラリパスを更新 – Linuxやってみる！]( https://www.dogrow.net/linux/blog6/ )

* まず，`ldd`で依存ライブラリの確認
* 一時的な解決策としては，
```
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib ./path_to_bin_file
```

## shared library search order
1. 環境変数で指定されたパス
  * `LD_LIBRARY_PATH`
  * `LD_LIBRARY_PATH_64`
2. `/etc/ld.so.conf` に記述されたパス
3. 通常ライブラリが置かれるパス
  * `/lib` (`/usr/lib` への symbolic link)
  * `/lib64` (`/usr/lib64` への symbolic link)

## shared libraryに依存する実行ファイルを他の環境でも動かしたい

step
1. 依存する共有ライブラリをリストアップしてコピー
2. 他の環境で見つからない共有ライブラリ__のみ__をロードして，実行する

1. 依存する共有ライブラリをリストアップ
`xxx`: 実行ファイル名
```
mkdir -p libs
lddtree -l xxx | xargs -L 1 -I{} cp {} libs
```

2. 他の環境で見つからない共有ライブラリ__のみ__をロードして，実行する
```
LD_LIBRARY_PATH=$(ldconfig -v 2>/dev/null | grep -v $'\t' | cut -d: -f1 | tr '\n' ':')"./libs" ./xxx
```

### NOTE
単純に，`LD_LIBRARY_PATH`を利用して，リストアップした共有ライブラリを__すべて__優先的にロードするようにすると，`Segmentation fault`が発生する
```
LD_LIBRARY_PATH=./libs ./xxx
Segmentation fault
```

共有ライブラリのsearch pathの一覧
```
ldconfig -v 2>/dev/null | grep -v $'\t' | cut -d: -f1 | tr '\n' ':'
# 簡易的な方法
cat /etc/ld.so.conf.d/*.conf | grep -v "^#" | tr '\n' ':'
```

`ldd ./xxx`とすることで簡単に依存関係がわかる

* opencvに依存するケースでも動作させた実績あり

### FYI
* `lddtree`: `sudo apt install pax-utils`
