import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/utils/simple_snackbar.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:flutter_login_facebook/flutter_login_facebook.dart';
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

  void login(BuildContext context,
      {@required String? email, @required String? password}) {
    // .trim() : 띄어쓰기 자동 삭제해주기
    _firebaseAuth
        .signInWithEmailAndPassword(
            email: email!.trim(), password: password!.trim())
        .catchError((error) {
      String _message = '';
      print(error);
      switch (error.code) {
        case 'invalid-email':
          _message = '유효하지 않은 매개변수입니다.';
          break;
        case 'user-disabled':
          _message = '접근 권한이 없습니다.';
          break;
        case 'user-not-found':
          _message = '계정을 찾을 수 없습니다.';
          break;
        case 'wrong-password':
          _message = '입력된 비밀번호가 올바르지 않습니다.';
          break;
      }
      SnackBar snackBar = SnackBar(
        content: Text(_message),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
          _message = '유효하지 않은 매개변수입니다.';
          break;
        case 'operation-not-allowed':
          _message = '허가되지 않은 작업입니다.';
          break;
        case 'weak-password':
          _message = '취약한 비밀번호입니다.';
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

// snack bar를 통하여 로그인 상태를 보여주기 위해서 BuildContext context를 받아옴.
  // void loginWithFacebook(BuildContext context) async {
  //   final facebookLogin = FacebookLogin();
  //   final result = await facebookLogin.logIn();

  //   switch (result.status) {
  //     case FacebookLoginStatus.success:
  //       _handleFacebookTokenWithFirebase(context, result.accessToken!.token);
  //       break;
  //     case FacebookLoginStatus.error:
  //       simpleSnackbar(context, 'Error while facebook sign in');
  //       break;
  //     case FacebookLoginStatus.cancel:
  //       simpleSnackbar(context, 'User cancel facebook sign in');
  //       break;
  //   }
  // }

  Future<UserCredential> signInWithFacebook(BuildContext context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

// snackbar를 위한 buildContext임.
  void _handleFacebookTokenWithFirebase(
      BuildContext context, String token) async {
    // TODO: 토큰을 사용해서 파이어베이스로 로그인하기.
    final AuthCredential credential = FacebookAuthProvider.credential(token);

    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final User? user = authResult.user;
    if (user == null) {
      simpleSnackbar(context, 'Error while facebook sign in');
    } else {
      _user = user;
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { signout, progress, signin }
