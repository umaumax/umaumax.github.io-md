# BogoMIPS

* `/proc/cpuinfo`や`lscpu`を使わずにCPUのクロック(周波数)を調べるときに利用できる
  * また，電圧によりクロックが異なることがあるので，起動時のBogoMIPSの値を見ることで，処理能力の値を把握できる

* BogoMips（"bogus"=「いんちきの」+ MIPS）とは、Linuxカーネルのブート時にCPU速度をビジーループを使って非科学的に測定した結果である[1]。その定義としてよく言われるのは「プロセッサが全く無駄な処理を1秒間に何百万回できるか」である
* 100万=10^6=M
* 基本的には，`clock*2`の値となるので，次のclockは`1.5GHz`
```
$ cat /proc/cpuinfo | grep BogoMIPS
BogoMIPS	: 2996.63
```
* 例として，下記では2倍の値になっている
  * [cpuの情報を見る方法\(mac/linux\) \- mikami's blog]( http://mikamisan.hatenablog.com/entry/2017/01/09/101739 )
  * [hwinfoを使ってハードウェア情報を簡単取得 \- Qiita]( https://qiita.com/isaoshimizu/items/58123fd0d47fc7ffbfbe )

