import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// firebase_auth: ^0.18.0부터는 변경 전에서 변경 후 값을 사용하세요!^^
// 변경전 => 변경후
// FirebaseUser => User
// AuthResult => UserCredential
// currentUser() => currentUser
// onAuthStateChanged => authStateChanges()

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.progress;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges();
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_user != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }

    notifyListeners();
  }
}

enum FirebaseAuthStatus { signout, progress, signin }
