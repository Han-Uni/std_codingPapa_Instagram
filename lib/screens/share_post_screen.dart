import 'dart:io';

import 'package:flutter/material.dart';

class SharePostScreen extends StatelessWidget {
  final File? imageFile;

  // 중괄호{} 안에 있으면 option값이 되니까 imageFile을 필수로 받기 위해서 중괄호 밖으로 빼준다.
  const SharePostScreen(this.imageFile, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(imageFile!);
  }
}
