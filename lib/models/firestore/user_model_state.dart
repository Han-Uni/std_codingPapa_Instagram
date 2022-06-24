import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model.dart';

class UserModelState extends ChangeNotifier {
  UserModel? _userModel;
  StreamSubscription<UserModel>? _currentStreamSub;

  UserModel get userModel => _userModel!;
  StreamSubscription<UserModel>? get currentStreamSub => _currentStreamSub;

  set userModel(UserModel userModel) {
    _userModel = userModel;

    notifyListeners();
  }

  set currentStreamSub(StreamSubscription<UserModel>? currentStremSub) =>
      _currentStreamSub = currentStremSub;

  clear() async {
    if (_currentStreamSub != null) {
      await _currentStreamSub?.cancel();
      // _currentStreamSub = null;
    } else {}
    _currentStreamSub = null;
    _userModel = null;
  }

  bool amIFollwingThisUser(String otherUserKey) {
    if (_userModel == null ||
        _userModel!.followings == null ||
        _userModel!.followings.isEmpty) return false;
    return _userModel!.followings.contains(otherUserKey);
  }
}
