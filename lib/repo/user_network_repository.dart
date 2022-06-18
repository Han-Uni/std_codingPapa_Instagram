import 'package:cloud_firestore/cloud_firestore.dart';

class UserNetworkRepository {
  //var db = FirebaseFirestore.instance;
  Future<void> sendData() {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc("111111")
        .set({"email": "111@gmail.com", "username": "myUserName"});
  }

  void getData() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc("111111")
        .get()
        .then((docSnapshot) => print(docSnapshot.data()));
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();
