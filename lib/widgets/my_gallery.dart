import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/models/gallery_state.dart';
import 'package:local_image_provider/device_image.dart';
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
          children: getImages(galleryState),
        );
      },
    );
  }

  List<Widget> getImages(GalleryState galleryState) {
    return galleryState.images!
        .map((localImage) => Image(image: DeviceImage(localImage)))
        .toList();
  }
}
