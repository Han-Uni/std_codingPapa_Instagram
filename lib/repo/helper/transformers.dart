import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final toPosts = StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
      List<PostModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<PostModel> posts = [];

    snapshot.docs.forEach((documentSnapshot) {
      posts.add(PostModel.fromSnapshot(documentSnapshot));
    });
    sink.add(posts);
  });
}
