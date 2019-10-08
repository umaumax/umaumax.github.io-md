# autofs

[https://docs\.oracle\.com/cd/E19253\-01/819\-0381/rfsrefer\-75/index\.html]( https://docs.oracle.com/cd/E19253-01/819-0381/rfsrefer-75/index.html )
* autofs マウントが設定されると、要求があったときにファイルシステムをマウントする
  * この処理を担うデーモンが`automountd`
  * timeout指定でアンマウントされるまで，`automountd`が動作していないなくとも動作には問題ない
  * マウント先が起動していないもしくは再起動した場合でも，アクセスするたびにマウントを試すため，特に問題はないと考えられる

環境: ubuntu 16.04

## 実現したいコマンド
```
sudo mount -t nfs $target_host_addr:/opt/remote_data /opt/local_data
```

## install
```
sudo apt-get install -y autofs
```

## setting
```
echo "/- /etc/auto.opt.data --timeout=60" | sudo tee -a /etc/auto.master
echo "/opt/local_data -fstype=nfs,r $target_host_addr:/opt/remote_data" | sudo tee /etc/auto.opt.data

sudo service autofs restart
```

* `/etc/auto.master`に接続したいファイルパスとそのパスに対応する設定ファイルのパスを記述し，設定ファイルを新規作成し，その中に，設定を書き込む
* `/etc/auto.master`にて`/opt`とすると、`/opt`自体がまず`autofs`typeでmountされる状態となるため(`mount`コマンドで確認可能)、`/opt/xxx`などのファイルやディレクトリはunmountするまで見えなくなるため、今回のケースではダイレクトマップ形式を利用
* `timeout`(defulat: 600sec)

----

## troubleshooting
### 接続できない
```
mount.nfs: access denied by server while mounting
```

* NFSサーバ側で，`exportfs -v`, `showmount -e`でクライアントのIPアドレスが許可されているかどうか確認
  * 必要に応じて，`sudo vim /etc/exports`で編集して`sudo exportfs -ra`で動作を中断せずに更新可能

### デバッグしたい
```
# sudo service autofs restart
# cat /var/log/syslog

# or

sudo service autofs stop
sudo /usr/sbin/automount -f -v
sudo service autofs start
```

### 確認方法
```
$ mount
...
...
/etc/auto.opt.data on /opt/local_data type autofs (rw,relatime,fd=6,pgrp=1330,timeout=60,minproto=5,maxproto=5,direct,pipe_ino=131609717)
$target_host_addr:/opt/remote_data on /opt/local_data type nfs4 (rw,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=yy.yy.yy.yy,local_lock=none,addr=xx.xx.xx.xx)
```

### 同一のディレクトリにmountしてしまった場合
* `sudo umount`ではhang upしてしまい，rebootをすると直った
  * このとき，対象のディレクトリに対するアクセスをする動作に対するレスポンスが非常に遅い(or 応答なし)のため，`ls`や`bash`での補完機能でアクセスする際にterminalが固まってしまうため注意

## FYI
* [automount の設定 \- maruko2 Note\.]( http://www.maruko2.com/mw/automount_%E3%81%AE%E8%A8%AD%E5%AE%9A )
* [9\.4\.2\. autofs の設定 Red Hat Enterprise Linux 6 \| Red Hat Customer Portal]( https://access.redhat.com/documentation/ja-jp/red_hat_enterprise_linux/6/html/storage_administration_guide/s2-nfs-config-autofs )
* [autofsの設定 \- かえでのWebログ]( https://kaede.adiary.jp/nfs-on-autofs )
