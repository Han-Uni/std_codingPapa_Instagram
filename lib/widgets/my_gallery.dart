import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/models/gallery_state.dart';
import 'package:flutter_bottom_navigationbar/screens/share_post_screen.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyGallery extends StatefulWidget {
  const MyGallery({Key? key}) : super(key: key);

  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryState>(
      builder: (context, galleryState, child) {
        return GridView.count(
          crossAxisCount: 3,
          children: getImages(context, galleryState),
        );
      },
    );
  }

  List<Widget> getImages(BuildContext context, GalleryState galleryState) {
    // gallery에서 이미지를 불러오려면 File을 사용해야함.
    // LocalImage -> File(X), LocalImage -> Byte -> File로 변환해야함.
    return galleryState.images!
        .map((localImage) => InkWell(
            onTap: () async {
              // ????? deprecated 된 .getScaledImageBytes를 DeviceImage로 어떻게 바꾸는걸까? deviceImage는 imageProvider를 사용하던디...
              // localImage -> Bytes로 변환!!
              Uint8List bytes = await localImage.getScaledImageBytes(
                  galleryState.localImageProvider!, 0.3);

              // millisecondsSinceEpoch : 1970-01-01T00:00:00Z (UTC) 이 시간처럼 나타내주는 것.
              // timeInMilli : 파일명이 됨.
              final String timeInMilli =
                  DateTime.now().millisecondsSinceEpoch.toString();
              try {
                // getTemporaryDirectory.path로 String 값을 만들어 파일명.확장자와 같이 붙여줌. : 저장위치
                // (await getTemporaryDirectory()).path + '$timeInMilli.png' 로 사용할 수 있지만 어떤 위험때문에 join을 사용해서 진행한다.
                final path = join(
                    (await getTemporaryDirectory()).path, '$timeInMilli.png');
                // .. : 구문임. 생성된 생성된 File(path)에 writeAsBytesSync메소드를 실행함.
                // Bytes -> File로 변환!!
                File imageFile = File(path)..writeAsBytesSync(bytes);
                // (_) : context를 builder를 통해서 받는데 사용을 안하니까 저렇게 표현해줌.
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SharePostScreen(imageFile)));
              } catch (e) {}
              ;
            },
            child: Image(
              // 기본 scale : 1이기 때문에 메모리를 너무 많이 차지하여 scale로 0.1 또는 0.2로 변경해주면 메모리 이슈는 사라짐.
              image: DeviceImage(localImage, scale: 0.2),
              // 이미지를 정사각형에 꽉차면서 짤리는 부분은 안보이게 해줄때 사용
              fit: BoxFit.cover,
            )))
        .toList();
  }
}
