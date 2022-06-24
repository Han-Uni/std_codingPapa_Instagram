import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/models/firebase_auth_state.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/post_model.dart';
import 'package:flutter_bottom_navigationbar/repo/post_network_repository.dart';
import 'package:flutter_bottom_navigationbar/repo/user_network_repository.dart';
import 'package:flutter_bottom_navigationbar/widgets/post.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  final List<dynamic> followings;
  const FeedScreen(this.followings, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PostModel>>(
      initialData: [],
      create: (BuildContext context) =>
          postNetworkRepository.fetchPostsFromAllFollowers(followings),
      child: Consumer<List<PostModel>>(
        builder: (BuildContext context, List<PostModel> posts, Widget? child) {
          if (posts == null || posts.isEmpty) {
            return Scaffold(
              appBar: FeedScrean_Appbar(context),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.do_not_disturb_sharp,
                      size: 100,
                    ),
                    Text('NO DATA'),
                    Text('팔로워가 없습니다.'),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: FeedScrean_Appbar(context),
              body:
                  // ListView.builder(
                  //   itemBuilder: feedListBuilder,
                  //   itemCount: 30,
                  // )

                  ListView.builder(
                itemBuilder: (context, index) =>
                    feedListBuilder(context, posts[index]),
                itemCount: posts.length,
              ),
            );
          }
        },
      ),
    );
  }

  CupertinoNavigationBar FeedScrean_Appbar(BuildContext context) {
    return CupertinoNavigationBar(
      leading: IconButton(
        onPressed: null,
        icon: Icon(
          CupertinoIcons.camera,
          color: Colors.black87,
        ),
      ),
      middle: Text(
        'Instagram',
        style: TextStyle(fontFamily: 'VeganStyle', color: Colors.black),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Provider.of<FirebaseAuthState>(context, listen: false).signOut();
            },
            icon: ImageIcon(AssetImage('assets/images/actionbar_camera.png')),
            color: Colors.black87,
          ),
          IconButton(
            onPressed: () {
              userNetworkRepository.getAllUsersWithoutMe().listen((users) {
                print('### is Logged : users : $users');
              });
            },
            icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget feedListBuilder(BuildContext context, PostModel postModel) {
    return Post(postModel);
  }
}
