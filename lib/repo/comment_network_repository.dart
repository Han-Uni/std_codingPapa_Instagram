import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bottom_navigationbar/constants/firestore_keys.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/comment_model.dart';
import 'package:flutter_bottom_navigationbar/repo/helper/transformers.dart';

class CommentNetworkRepository with Transformers {
  Future<void> createNewComment(
      String postKey, Map<String, dynamic> commentData) async {
    final DocumentReference postRef =
        FirebaseFirestore.instance.collection(COLLECTION_POSTS).doc(postKey);
    final DocumentSnapshot postSnapshot = await postRef.get();
    final DocumentReference commentRef =
        postRef.collection(COLLECTION_COMMENTS).doc();

    return FirebaseFirestore.instance.runTransaction((tx) async {
      if (postSnapshot.exists) {
        await tx.set(commentRef, commentData);

        int numOfComments = postSnapshot[KEY_NUMOFCOMMENTS];
        await tx.update(postRef, {
          KEY_NUMOFCOMMENTS: numOfComments + 1,
          KEY_LASTCOMMENT: commentData[KEY_COMMENT],
          KEY_LASTCOMMENTOR: commentData[KEY_LASTCOMMENTOR],
          KEY_LASTCOMMENTTIME: commentData[KEY_LASTCOMMENTTIME]
        });
      }
    });
  }

  Stream<List<CommentModel>> fetchAllComments(String postKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_POSTS)
        .doc(postKey)
        .collection(COLLECTION_COMMENTS)
        .orderBy(KEY_COMMENTTIME)
        .snapshots()
        .transform(toComments);
  }
}

CommentNetworkRepository commentNetworkRepository = CommentNetworkRepository();
