import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bottom_navigationbar/constants/auth_input_decor.dart';
import 'package:flutter_bottom_navigationbar/constants/common_size.dart';
import 'package:flutter_bottom_navigationbar/constants/screen_size.dart';

class SharePostScreen extends StatelessWidget {
  final File? imageFile;
  final String? postKey;

  // 중괄호{} 안에 있으면 option값이 되니까 imageFile을 필수로 받기 위해서 중괄호 밖으로 빼준다.
  const SharePostScreen(this.imageFile, {Key? key, @required this.postKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'New Post', textAlign: TextAlign.center,
            // textScaleFactor: 1.4,
          ),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'share',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: common_gap, vertical: common_gap),
              leading: AspectRatio(
                aspectRatio: 1,
                child: Image.file(
                  imageFile!,
                  //width: size!.width / 6,
                  //height: size!.height / 6,
                  fit: BoxFit.fill,
                ),
              ),
              title: TextFormField(
                decoration: InputDecoration(
                  hintText: 'sdfsdf',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ));
  }
}
