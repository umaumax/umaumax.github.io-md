# zsh

## process substitution
[bashのプロセス置換機能を活用して、シェル作業やスクリプト書きを効率化する \- 双六工場日誌]( http://sechiro.hatenablog.com/entry/2013/08/15/bash%E3%81%AE%E3%83%97%E3%83%AD%E3%82%BB%E3%82%B9%E7%BD%AE%E6%8F%9B%E6%A9%9F%E8%83%BD%E3%82%92%E6%B4%BB%E7%94%A8%E3%81%97%E3%81%A6%E3%80%81%E3%82%B7%E3%82%A7%E3%83%AB%E4%BD%9C%E6%A5%AD%E3%82%84%E3%82%B9 )

> 最初に注意点ですが、プロセス置換の機能は、bashやzsh*1の機能でPOSIX互換の機能ではありません。そのため、使用時には、対応していないシェルでは使えませんし、bashで使う場合も /bin/sh ではなく /bin/bash を明示的に指定する必要があります。

## how to check format
```
echo 'cat <(echo 1)' | bash --posix -n
echo 'cat <(echo 1)' | bash -n
```

## 変数の中身を__そのまま__表示させたい場合には
```sh
printf '%s' "$var"
```
とするべき

```sh
$ cmd='sample\n'
$ echo "$cmd"
sample
$ printf '%s' "$cmd"
sample\n
```

## fg

* `C-z` -> `fg`

NOTE: __shellのビルトインコマンドを使用すること__(zshでは?)
```
$ type fg
fg is a shell builtin
fg is /usr/bin/fg
```

## use set -e in partly
[bash \- Local \`set \-e\` for functions \- Unix & Linux Stack Exchange]( https://unix.stackexchange.com/questions/207732/local-set-e-for-functions )

```
$ echo $(set -e; $(exit 0); echo "called!")
called!
$ echo $(set -e; $(exit 1); echo "called!")

```

## process substitute
1回だけ有効
```
$ bash -c 'cat $0; cat $0' <(echo 123)
123
```

下記は2回利用している疑惑
```
bind -f $inputrc_filepath
```

## exit code
```
	a=$(echo | sed)
	echo $?
	最後のコマンドの結果

	local a=$(echo | sed)
	echo $?
	最後のlocalのコマンドの結果
```

## subshell?
```
{ export TMP='hello'; echo 123; } | :
echo "hello=$TMP"
# hello=

{ export TMP='hello'; echo 123; }
echo "hello=$TMP"
# hello=hello
```

## shift
```
$ a=(1 2 3)
$ echo "${a[@]}"
1 2 3
$ shift a
$ echo "${a[@]}"
2 3
$ shift a
$ echo "${a[@]}"
3
```

## zsh interactive mode
* zsh起動直後にすぐにクリップボードからの貼付けをすると文字入力として解釈される
  * つまり，`()`や`''`などの文字列が含まれる場合に，設定したzshの自動補完が動作するため，予期しないコマンドが入力されてしまう

## zsh precmd
get current command
[zsh \- Is there a hook\-like system for shell? \- Unix & Linux Stack Exchange]( https://unix.stackexchange.com/questions/102595/is-there-a-hook-like-system-for-shell )
```
$history[$[HISTCMD-1]]
```

## zle
zle中であるかどうかは

`zle`の終了コードで判断できるが，これは直接
```
zle -N _func_name
```
で登録されていないダメっぽい(上記の登録関数内での呼び出しではダメ...)

zle中では下記がtrueとなる
```
[[ ! -o zle ]]
```

## PS1 newline
### bash
* [bash \- Displaying a new line on the prompt \- Ask Ubuntu]( https://askubuntu.com/questions/16424/displaying-a-new-line-on-the-prompt )
### zsh
* [What's the newline symbol in zsh's PS1? \- Unix & Linux Stack Exchange]( https://unix.stackexchange.com/questions/53789/whats-the-newline-symbol-in-zshs-ps1 )
`$'\n'`
* [zsh zle \- zsh new line prompt after each command \- Stack Overflow]( https://stackoverflow.com/questions/20512957/zsh-new-line-prompt-after-each-command )
`function precmd() { echo -n ''; }`

## 関数一覧表示(名前のみ)
[Any way to get list of functions defined in zsh \(like alias command for aliases\) \- Super User]( https://superuser.com/questions/681575/any-way-to-get-list-of-functions-defined-in-zsh-like-alias-command-for-aliases )

```
print -l ${(ok)functions}
```

## grepのファイル出力を指定のディレクトリで行う
```
grep -ns "" $DIR_PATH/* | sed 's:'$DIR_PATH/'::g'
```

## zshのfunction内のalias
```
echo '# in function (alias is disable)'
sed --version
echo '# in $() in function (alias is enable)'
echo $(sed --version)
```

## 変数に代入して，すぐに使用するときの注意
```
$ hoge=123 echo $hoge

$ hoge=123 && echo $hoge
123
```

## [「iTerm2でzsh補完するときディレクトリが真っ青で見にくいよ問題」を解決する方法 \- Qiita]( https://qiita.com/nishina555/items/c3cdab6d059ee494c66e )
* [【iTerm2 \+ zsh】色設定をする \- footmark]( http://yuk.hatenablog.com/entry/2014/09/23/072648 )
### TL;DR
iTerm2の色設定を変更する
Tango Darkがおすすめ

## reapath
clean or normalize filepath commmand
[linux \- How do you normalize a file path in Bash? \- Stack Overflow]( https://stackoverflow.com/questions/284662/how-do-you-normalize-a-file-path-in-bash )
```
realpath /usr/bin/../lib/gcc/x86_64-linux-gnu/5.4.0/../../../../include/c++/5.4.0
```
* 存在自体は調べない

----

## cmds

## pushd and popd
* `pushd`中に`cd`するには`pushd .`をはさんでから，`popd`を1回余計に使う必要がある
  * もしくは，すべて，`pushd`と`popd`のセットとする
[ディレクトリの移動は cd コマンドよりも pushd コマンドのほうが便利！ \- Qiita]( https://qiita.com/noraworld/items/81c12253d22b7575151a#%E3%82%B9%E3%82%BF%E3%83%83%E3%82%AF%E3%81%AB%E4%BF%9D%E5%AD%98%E3%81%9B%E3%81%9A%E3%81%AB%E7%A7%BB%E5%8B%95%E3%81%97%E3%81%9F%E3%81%84%E5%A0%B4%E5%90%88 )

## tar
* read権限のないファイルでもファイルサイズが0の場合にはtarでエラーが起きない

## scp
* scpするとlnが実体になってしまうので注意
  * tarもしくは、rsyncのaオプションを利用するべき

## sshfs
* sshfsでは，hostの後のpathに`~`を指定しても展開されないので注意
  * scpでは展開される

## cp note

__don't use cp `-r`__

[cpコマンドでディレクトリを再帰的にコピーする時に気持ちが伝わらなすぎるのでcpコマンドでの失敗を記録してみた \- Qiita]( https://qiita.com/ponsuke0531/items/660bcbf12e0692a49d12 )

```
src/src.txt

dst/
```

### mac
```
$ cp -r src/ dst
$ cp -r src/ dst/
$ cp -R src/ dst
$ cp -R src/ dst/
$ cp -rT src dst
$ cp -rT src dst/
$ cp -rT src/ dst
$ cp -rT src/ dst/
$ cp -RT src dst
$ cp -RT src dst/
$ cp -RT src/ dst
$ cp -RT src/ dst/
dst/src.txt

$ cp -r src dst
$ cp -r src dst/
$ cp -R src dst
$ cp -R src dst/
dst/src/src.txt
```

* `-R`でも`-r`でも基本的に同じ
* dstの`/`は関係ない
* gnu限定で`-T`を付加すると期待通りの結果となりやすい

* 基本的に，srcには`/`を付加し，dstにはディレクトリ名を含めて指定すると良い(ディレクトリは自動生成される)

* ubuntuではcpのsrc/のslashの有無にかかわらずTを付加しないとダメ
  * cp -RT src ../xxx/src

## 関数を(コピーして)renameしたい
[zsh \- Rename selfdefined function \- Super User]( https://superuser.com/questions/553153/rename-selfdefined-function )

```
rename_func() {
    if (( $# != 2 )); then
        echo "Usage: rename_func <oldname> <newname>" >&2
        return 1
    fi
    oldname=$1
    newname=$2
    local code=$(echo "$newname () {"; whence -f $oldname | tail -n +2)
    unset -f $oldname
    eval "$code"
}
```

----

## Question
* 前回のコマンドの実行結果の利用
	* コマンドhookでできないかどうか
