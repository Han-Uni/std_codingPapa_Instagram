import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bottom_navigationbar/constants/firestore_keys.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model.dart';
import 'package:flutter_bottom_navigationbar/repo/helper/transformers.dart';

class UserNetworkRepository with Transformers {
  Future<void> attemptCreateUser({String? userKey, String? email}) async {
    final DocumentReference userRef =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);
    DocumentSnapshot snapshot = await userRef.get();
    if (!snapshot.exists) {
      return await userRef.set(UserModel.getMapForCreateUser(email!));
    } else {}
  }

// Stream 사용 이유 : get은 한번만 가져오는데 로그인 한 user가 변화할 때마다 가져올것이기 때문에 Stream을 사용함.
  Stream<UserModel> getUserModelStream(String userKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(userKey)
        .snapshots()
        // 현재 타입은 UserModel을 받아와야하는데 snapshots의 타입은 DocumentSnapshot이기 때문에 transform을 사용하여 변화줌
        .transform(toUser);
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();
