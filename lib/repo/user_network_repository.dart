import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bottom_navigationbar/constants/firestore_keys.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model.dart';

class UserNetworkRepository {
  Future<void>? attemptCreateUser({String? userKey, String? email}) async {
    final DocumentReference userRef =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);
    DocumentSnapshot snapshot = await userRef.get();
    if (!snapshot.exists) {
      return await userRef.set(UserModel.getMapForCreateUser(email));
    } else {}
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();
