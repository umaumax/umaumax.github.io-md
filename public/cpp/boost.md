# boost

## how to build

[Boostライブラリのビルド方法 \- boostjp]( https://boostjp.github.io/howtobuild.html )

```
git clone https://github.com/boostorg/boost.git
cd boost

git checkout -b boost-1.71.0 boost-1.71.0
# this takes a lot of time (3min~)
git submodule update --init --recursive

boost_version_prefix=$(basename $(git rev-parse --abbrev-ref HEAD) | sed -E 's/[-.]/_/g')
echo "boost_version_prefix:$boost_version_prefix"
PREFIX=~/local/
mkdir -p $PREFIX/$boost_version_prefix
ln -sf ./$boost_version_prefix $PREFIX/boost

./bootstrap.sh
```

### only header install
```
## To generate header files, run:
./b2 headers
# output dir is `./boost`
```

### all libs install
```
# this takes a lot of time (30min~)
# To build, run:
./b2 install -j4 --prefix=$PREFIX/$boost_version_prefix
```

### 特定のライブラリのみをビルドする
* `--with-xxx` e.g. `--with-python`

有効・無効にできるライブラリ一覧
```
Component configuration:

    - atomic                   : building
    - chrono                   : building
    - container                : building
    - context                  : building
    - contract                 : building
    - coroutine                : building
    - date_time                : building
    - exception                : building
    - fiber                    : building
    - filesystem               : building
    - graph                    : building
    - graph_parallel           : building
    - headers                  : building
    - iostreams                : building
    - locale                   : building
    - log                      : building
    - math                     : building
    - mpi                      : building
    - program_options          : building
    - python                   : building
    - random                   : building
    - regex                    : building
    - serialization            : building
    - stacktrace               : building
    - system                   : building
    - test                     : building
    - thread                   : building
    - timer                    : building
    - type_erasure             : building
    - wave                     : building
```
