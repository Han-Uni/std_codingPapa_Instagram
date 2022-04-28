import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

// firebase_auth: ^0.18.0부터는 변경 전에서 변경 후 값을 사용하세요!^^
// 변경전 => 변경후
// FirebaseUser => User
// AuthResult => UserCredential
// currentUser() => currentUser
// onAuthStateChanged => authStateChanges()

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user == null && _user == null) {
        return;
      } else if (user != _user) {
        _user = user;
        changeFirebaseAuthStatus();
      }
    });
  }

  void login({@required String? email, @required String? password}) {
    // .trim() : 띄어쓰기 자동 삭제해주기
    _firebaseAuth
        .signInWithEmailAndPassword(
            email: email!.trim(), password: password!.trim())
        .catchError((error) {
      String _message;
      print(error);
      switch (error.code) {
        case 'invalid-email':
          _message = 'invalid-email';
          break;
        case 'user-disabled':
          _message = 'user-disabled';
          break;
        case 'user-not-found':
          _message = 'user-not-found';
          break;
        case 'wrong-password':
          _message = 'wrong-password';
          break;
      }
    });
  }

  void registerUser(BuildContext context,
      {@required String? email, @required String? password}) {
    String _message = '';
    // .trim() : 띄어쓰기 자동 삭제해주기
    _firebaseAuth
        .createUserWithEmailAndPassword(
            email: email!.trim(), password: password!.trim())
        .catchError((error) {
      switch (error.code) {
        case 'email-already-in-use':
          _message = '이미 존재하는 이메일 주소입니다.';
          break;
        case 'invalid-email':
          _message = '유효하지 않은 매개변수';
          break;
        case 'operation-not-allowed':
          _message = '허가되지 않은 주소.';
          break;
        case 'weak-password':
          _message = '비밀번호 취약함';
          break;
      }
      SnackBar snackBar = SnackBar(
        content: Text(_message),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void signOut() {
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_user != null) {
      _user = null;
      _firebaseAuth.signOut();
    }
    notifyListeners();
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

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { signout, progress, signin }
