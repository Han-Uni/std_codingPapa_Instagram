import 'package:flutter_bottom_navigationbar/models/firestore/User_model.dart';

String getNewPostKey(UserModel userModel) =>
    "${DateTime.now().millisecondsSinceEpoch}_${userModel.userKey}";
