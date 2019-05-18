# svg

## TL;DR
* web上のsvgファイルをコピーしてpower pointで利用したい場合には，画像としてコピーするのが無難
  * もちろん，ファイルとして，ローカルにダウンロードしてドラッグ&ドロップすればよいが...(この手順が面倒)
  * 理想としては，chrome extensionを利用して，クリップボードへの貼付けを行うこと?

----

* [google chrome \- Copy SVG Images from Browser to Clipboard \- Stack Overflow]( https://stackoverflow.com/questions/12255444/copy-svg-images-from-browser-to-clipboard )

### github上でのsvgファイル
画像として表示される
* e.g.
  * [simple\-icons/500px\.svg at develop · simple\-icons/simple\-icons]( https://github.com/simple-icons/simple-icons/blob/develop/icons/500px.svg )
  * [include an SVG \(hosted on github\) in MarkDown \- Stack Overflow]( https://stackoverflow.com/questions/13808020/include-an-svg-hosted-on-github-in-markdown )
    * [StackOverflow/readme\.md at master · potherca\-blog/StackOverflow]( https://github.com/potherca-blog/StackOverflow/blob/master/question.13808020.include-an-svg-hosted-on-github-in-markdown/readme.md )

## how to display svg as png
### base64
```
<img src="data:image/svg+xml;base64,CjwhLS0gR2VuZXJhdGVkIHdpdGggaHR0cDovL2p4bmJsay5jb20vcGF0aHMgLS0+CjxzdmcKICB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnCiAgdmlld0JveD0nMCAwIDY0IDY0JwogIHdpZHRoPSc2NCcgaGVpZ2h0PSc2NCcKICBmaWxsPSdjdXJyZW50Y29sb3InPgogIDxwYXRoIGQ9J001MiAzNCBMNTIgMzggTDYwIDMyIEw1MiAyNiBMNTIgMzAgTDQgMzAgTDQgMzQgWicgLz4KPC9zdmc+" width="100" height="100" alt="diagram" />
```

### url
```
<img src="https://upload.wikimedia.org/wikipedia/commons/1/1f/Clipboard.svg" width="100" height="100" alt="diagram" />
```
