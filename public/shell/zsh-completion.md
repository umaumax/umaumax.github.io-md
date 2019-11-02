# zshでの自作コマンド補完

## 既存のzshrcに追加する例
[zshでサブコマンドとファイル名を手抜き補完する \- Glide Note]( https://blog.glidenote.com/blog/2012/05/03/zsh-completion/ )
下記を実行し，`hoge`と入力した後にtabを入力すると補完される
```
compdef _hogecmd hoge
function _hogecmd {
  local -a cmds
  if (( CURRENT == 2 ));then
    cmds=('init' 'update' 'upgrade' 'commit')
    _describe -t commands "subcommand" cmds
  else
    _files
  fi

  return 1;
}
```

## fpathにファイルを追加する例
```
fpath=(
  ~/local/share/zsh/site-functions
  $fpath
)
mkdir -p ~/local/share/zsh/site-functions
```

[zsh の補完関数の自作導入編]( https://gist.github.com/mitukiii/4954559 )

```
function nyan() {
  echo 'nya-!'
}
```

`~/local/share/zsh/site-functions/_nyan`
```
#compdef nyan

_nyan() {
  _values \
    'mode' \
    'neko' \
    'usagi' \
    'kuma' \
    'github'
}
```

## 自作のgit subcommandの補完をしたい場合

下記のrepoが参考になりそうだが，うまくいかず...
[tj/git\-extras: GIT utilities \-\- repo summary, repl, changelog population, author commit percentages and more]( https://github.com/tj/git-extras )

下記は参考になる
[git\-flow\-completion/git\-flow\-completion\.zsh at master · bobthecow/git\-flow\-completion]( https://github.com/bobthecow/git-flow-completion/blob/master/git-flow-completion.zsh )

方針: `/usr/local/share/zsh/site-functions/_git`のソースコードを参考に拡張することを目指す
調査結果: `__git_zsh_bash_func`内では`emulate -L ksh`の状態で`_git_xxx`の関数が存在するかどうかを判定し，それを呼び出しているので，`_git_xxx`を定義すれば自動的に補完されるようになる

補足
fpathに存在するファイル名で
```
_xxx () {
	# undefined
	builtin autoload -XUz
}
```
が宣言される

結論
`_git_animal`
```
#compdef git-animal

_git_animal() {
  emulate -L zsh

  _values \
    'mode' \
    'cat' \
    'dog' \
    'bird'
}
```
とすると，`_git-animal`という関数は存在しないが，`git-animal`関数の補完用の関数は`_git_animal`となる
かつ，
このファイルの`_git-animal`を遅延読み込みする関数が自動生成されるので
`git-animal`と`git animal`の両方の補完を行うことができる

## 任意のコマンドの補完をhookしたい
`_git`のsubcommandの拡張は`_git`の中で用意されているが，そうではないコマンドの場合には下記の手法でhookすることができる

`~/local/share/zsh/site-functions/_git`: `$fpath`に記載された`/usr/local/share/zsh/site-functions/_git`よりも前のpathに配置
```
#compdef git

. /usr/local/share/zsh/site-functions/_git

# FYI: [zsh \- Rename selfdefined function \- Super User]( https://superuser.com/questions/553153/rename-selfdefined-function )
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

# NOTE: this replace above file's _git function
rename_func _git _git_orig

# 1st call: original _git call of above source file
# 2nd~ calls: this function
_git() {
  # local cur=${words[CURRENT]}
  local prev=${words[CURRENT-1]}
  if type >/dev/null 2>&1 _git_${prev}; then
    _git_${prev}
    return
  fi
  _git_orig
}
```

----

## Q&A
### 補完の優先順位は?
`$fpath`の検索で最初にhitしたファイル

### zshで補完が効かない
```
rm ~/.zcompdump
```

* 特に新規に`$fpath`を追加して，そこにファイルを追加した際にこの現象に遭遇する
  * また，`_xxx`のファイルを編集した場合にも上記コマンドを実行する必要があるため注意
* 現在存在しないコマンド補完ファイルが保管される場合には上記のcacheが原因である
