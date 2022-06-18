import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bottom_navigationbar/constants/firestore_keys.dart';

class UserModel {
  final String userKey;
  final String profileImg;
  final String email;
  final List<dynamic> myPosts;
  final int followers;
  final List<dynamic> likedPosts;
  final String username;
  final List<dynamic> followings;
  final DocumentReference? reference;

  UserModel.fromMap(Map<String, dynamic> map, this.userKey, {this.reference})
      : profileImg = map[KEY_PROFILEIMG],
        username = map[KEY_USERNAME],
        email = map[KEY_EMAIL],
        likedPosts = map[KEY_LIKEDPOSTS],
        followers = map[KEY_FOLLOWERS],
        followings = map[KEY_FOLLWINGS],
        myPosts = map[KEY_MYPOSTS];

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      //data() : document안의 data, id : document key, reference : document reference
      : this.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id,
            reference: snapshot.reference);

  // void printTest() {
  //   print('### is Logged : userModel.fromMap : ' +
  //       UserModel.fromMap(Map<ma, userKey>).toString());
  // }
}
