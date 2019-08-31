# OpenCV

## 静的ライブラリとしてビルドする

```
git clone https://github.com/opencv/opencv.git
cd opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_MODULE_TYPE=STATIC ..
make -j8
```

静的ライブラリ一覧
```
$ find . -name "*.a"
./lib/libopencv_photo.a
./lib/libopencv_videoio.a
./lib/libopencv_calib3d.a
./lib/libopencv_features2d.a
./lib/libopencv_dnn.a
./lib/libopencv_core.a
./lib/libopencv_imgcodecs.a
./lib/libopencv_highgui.a
./lib/libopencv_video.a
./lib/libopencv_gapi.a
./lib/libopencv_ml.a
./lib/libopencv_objdetect.a
./lib/libopencv_stitching.a
./lib/libade.a
./lib/libopencv_ts.a
./lib/libopencv_flann.a
./lib/libopencv_imgproc.a
./3rdparty/ippicv/ippicv_mac/icv/lib/intel64/libippicv.a
./3rdparty/lib/liblibtiff.a
./3rdparty/lib/liblibpng.a
./3rdparty/lib/liblibwebp.a
./3rdparty/lib/libquirc.a
./3rdparty/lib/libippiw.a
./3rdparty/lib/liblibprotobuf.a
./3rdparty/lib/libIlmImf.a
./3rdparty/lib/libzlib.a
./3rdparty/lib/liblibjasper.a
./3rdparty/lib/libittnotify.a
./3rdparty/lib/liblibjpeg-turbo.a
```

確認
```
opencv_version
```
