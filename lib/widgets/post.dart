import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bottom_navigationbar/constants/common_size.dart';
import 'package:flutter_bottom_navigationbar/constants/screen_size.dart';
import 'package:flutter_bottom_navigationbar/widgets/comment.dart';
import 'package:flutter_bottom_navigationbar/widgets/rounded_avatar.dart';
import 'package:flutter_bottom_navigationbar/widgets/y_progress_indicator.dart';

class Post extends StatelessWidget {
  final int index;

  Post(
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption(),
        // TextSpan을 사용할때는 Text color를 설정해줘야함. 초기값은 main의 primarySwatch 색상을 따라감.
      ],
    );
  }

  Widget _postCaption() {
    // RichText : 한개의 텍스트 안에 여러가지 텍스트 스타일을 가지고 있는 것.
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(
        userName: 'testingUser',
        text: 'i am hungry!!!',
        showImage: false,
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '12000 likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postActions() {
    return Row(
      children: const <Widget>[
        IconButton(
            onPressed: null,
            icon: ImageIcon(AssetImage('assets/images/bookmark.png'))),
        IconButton(
            onPressed: null,
            icon: ImageIcon(AssetImage('assets/images/comment.png'))),
        IconButton(
            onPressed: null,
            icon: ImageIcon(AssetImage('assets/images/direct_message.png'))),
        Spacer(),
        IconButton(
            onPressed: null,
            icon: ImageIcon(AssetImage('assets/images/heart_selected.png'))),
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
        imageUrl: 'https://picsum.photos/id/$index/2000/2000',
        placeholder: (context, url) => y_ProgressIndicator(
              containerSize: size?.width,
            ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageBuilder: (BuildContext buildContext, ImageProvider imageProvider) {
          return AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill)),
            ),
          );
        });
  }

  Widget _postHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(),
        ),
        Expanded(child: Text('userName')),
        IconButton(
          icon: Icon(Icons.more_horiz),
          onPressed: () {},
        )
      ],
    );
  }
}
