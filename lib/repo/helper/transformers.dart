import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model.dart';

class Transformers {
  final toUser = StreamTransformer<DocumentSnapshot<Map<String, dynamic>>,
      UserModel>.fromHandlers(handleData: (snapshot, sink) async {
    sink.add(UserModel.fromSnapshot(snapshot));
  });
}
