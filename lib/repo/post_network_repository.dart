import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bottom_navigationbar/constants/firestore_keys.dart';
import 'package:flutter_bottom_navigationbar/repo/helper/transformers.dart';

class PostNetworkRepository with Transformers {
  Future<void> createNewPost(
      String postKey, Map<String, dynamic> postData) async {
    final DocumentReference postRef =
        FirebaseFirestore.instance.collection(COLLECTION_POSTS).doc(postKey);
    final DocumentSnapshot postSnapshot = await postRef.get();

    final DocumentReference userRef = FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(postData[KEY_USERKEY]);

    FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      if (!postSnapshot.exists) {
        await tx.set(postRef, postData);
        await tx.update(userRef, {
          KEY_MYPOSTS: FieldValue.arrayUnion([postKey])
        });
      }
    });
  }

  Future<void> updatePostImageUrl({String? postImg, String? postKey}) async {
    final DocumentReference postRef =
        FirebaseFirestore.instance.collection(COLLECTION_POSTS).doc(postKey);
    final DocumentSnapshot postSnapshot = await postRef.get();

    if (postSnapshot.exists) {
      await postRef.update({KEY_POSTIMG: postImg});
    }
  }

  Stream<void> getPostsFromSpecificUser(String userKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_POSTS)
        .where(KEY_USERKEY, isEqualTo: userKey)
        .snapshots()
        .transform(toPosts);
  }
}

PostNetworkRepository postNetworkRepository = PostNetworkRepository();
