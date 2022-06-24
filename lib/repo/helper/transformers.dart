import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/comment_model.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/post_model.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model.dart';

class Transformers {
  final toUser = StreamTransformer<DocumentSnapshot<Map<String, dynamic>>,
      UserModel>.fromHandlers(handleData: (snapshot, sink) async {
    sink.add(UserModel.fromSnapshot(snapshot));
  });

  final toUsersExceptMe = StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
      List<UserModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<UserModel> users = [];

    User? _user = await FirebaseAuth.instance.currentUser;

    snapshot.docs.forEach((documentSnapshot) {
      if (_user!.uid != documentSnapshot.id) {
        users.add(UserModel.fromSnapshot(documentSnapshot));
      }
    });
    sink.add(users);
  });

  final toComments = StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
      List<CommentModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<CommentModel> comments = [];

    snapshot.docs.forEach((documentSnapshot) {
      comments.add(CommentModel.fromSnapshot(documentSnapshot));
    });
    sink.add(comments);
  });

  final toPosts = StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
      List<PostModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<PostModel> posts = [];

    snapshot.docs.forEach((documentSnapshot) {
      posts.add(PostModel.fromSnapshot(documentSnapshot));
    });
    sink.add(posts);
  });

  final combineListOfPosts =
      StreamTransformer<List<List<PostModel>>, List<PostModel>>.fromHandlers(
          handleData: (listOfPosts, sink) async {
    List<PostModel> posts = [];

    for (final postList in listOfPosts) {
      posts.addAll(postList);
    }
    sink.add(posts);
  });

  final latestToTop =
      StreamTransformer<List<PostModel>, List<PostModel>>.fromHandlers(
          handleData: (posts, sink) async {
    // a.postTime.compareTo(b.postTime) : 비교한 값 중 큰 값은 아래로 내려감.
    // 비교한 값 중 큰 값을 위로 올림.
    posts.sort((a, b) => b.postTime.compareTo(a.postTime));
    sink.add(posts);
  });
}
