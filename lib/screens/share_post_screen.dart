import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bottom_navigationbar/constants/common_size.dart';
import 'package:flutter_bottom_navigationbar/repo/image_network_repository.dart';
import 'package:flutter_bottom_navigationbar/widgets/y_progress_indicator.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

class SharePostScreen extends StatefulWidget {
  final File? imageFile;
  final String? postKey;

  // 중괄호{} 안에 있으면 option값이 되니까 imageFile을 필수로 받기 위해서 중괄호 밖으로 빼준다.
  SharePostScreen(this.imageFile, {Key? key, @required this.postKey})
      : super(key: key);

  @override
  State<SharePostScreen> createState() => _SharePostScreenState();
}

class _SharePostScreenState extends State<SharePostScreen> {
  List<String> _tagItems = [
    "approval",
    "pigeon",
    "brown",
    "expenditure",
    "compromise",
    "citizen",
    "inspire",
    "relieve",
    "grave",
    "incredible",
    "invasion",
    "voucher",
    "girl",
    "relax",
    "problem",
    "queue",
    "aviation",
    "profile",
    "palace",
    "drive",
    "money",
    "revolutionary",
    "string",
    "detective",
    "follow",
    "text",
    "bet",
    "decade",
    "means",
    "gossip"
  ];

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
                onPressed: () async {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) => y_ProgressIndicator(),
                      isDismissible: false,
                      enableDrag: false);
                  await imageNetworkRepository.uploadImageNCreateNewPost(
                      widget.imageFile!,
                      postKey: widget.postKey);
                  Navigator.of(context).pop();
                  print('### is Logged : imageFile : ' +
                      widget.imageFile.toString());
                  print(
                      '### is Logged : postKey : ' + widget.postKey.toString());
                },
                child: Text(
                  'share',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
        body: ListView(
          children: <Widget>[
            _captionWithImage(),
            _divider,
            _sectionButton('Tag People'),
            _divider,
            _sectionButton('Add Location'),
            _tags(),
            _divider,
            SectionSwitch('Facebook'),
            SectionSwitch('Twitter'),
            SectionSwitch('Tumblr'),
            _divider,
          ],
        ));
  }

  Tags _tags() {
    return Tags(
      heightHorizontalScroll: 39,
      horizontalScroll: true,
      itemCount: _tagItems.length,
      itemBuilder: (index) => ItemTags(
        index: index,
        title: _tagItems[index],
        activeColor: Colors.grey.shade200,
        textActiveColor: Colors.black,
        borderRadius: BorderRadius.circular(3),
        elevation: 2,
        color: Colors.grey.shade500,
      ),
    );
  }

  Divider get _divider => Divider(
        color: Colors.grey[300],
        thickness: 1,
        height: 1,
      );

  ListTile _sectionButton(String title) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: common_gap),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
            //textAlign: TextAlign.center,
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.navigate_next),
        color: Colors.grey[300],
        iconSize: 30,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
      ),
    );
  }

  ListTile _captionWithImage() {
    return ListTile(
      contentPadding:
          EdgeInsets.symmetric(horizontal: common_gap, vertical: common_gap),
      leading: AspectRatio(
        aspectRatio: 1,
        child: Image.file(
          widget.imageFile!,
          //width: size!.width / 6,
          //height: size!.height / 6,
          fit: BoxFit.fill,
        ),
      ),
      title: TextFormField(
        decoration: InputDecoration(
          hintText: 'Write acaption...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class SectionSwitch extends StatefulWidget {
  final String _title;
  const SectionSwitch(
    this._title, {
    Key? key,
  }) : super(key: key);

  @override
  State<SectionSwitch> createState() => _SectionSwitchState();
}

class _SectionSwitchState extends State<SectionSwitch> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: common_gap),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget._title,
            style: TextStyle(fontWeight: FontWeight.w500),
            //textAlign: TextAlign.center,
          ),
        ],
      ),
      trailing: CupertinoSwitch(
        onChanged: (onValue) {
          setState(() {
            checked = onValue;
          });
        },
        value: checked,
      ),
    );
  }
}
