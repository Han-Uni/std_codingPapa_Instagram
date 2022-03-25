import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/constants/matrial_white.dart';
import 'package:flutter_bottom_navigationbar/home_page.dart';
import 'package:flutter_bottom_navigationbar/models/firebase_auth_state.dart';
import 'package:flutter_bottom_navigationbar/screens/auth_screen.dart';
import 'package:flutter_bottom_navigationbar/widgets/y_progress_indicator.dart';
import 'package:provider/provider.dart';

// firebase_auth: ^0.18.0부터는 변경 전에서 변경 후 값을 사용하세요!^^
// 변경전 => 변경후
// FirebaseUser => User
// AuthResult => UserCredential
// currentUser() => currentUser
// onAuthStateChanged => authStateChanges()

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(InstaCloneApp());
}

class InstaCloneApp extends StatefulWidget {
  const InstaCloneApp({Key? key}) : super(key: key);

  @override
  _InstaCloneAppState createState() => _InstaCloneAppState();
}

class _InstaCloneAppState extends State<InstaCloneApp> {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseAuthState>.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        //home: AuthScreen(),
        // home: Consumer<FirebaseAuthState>(
        //     builder: (BuildContext context, FirebaseAuthState firebaseAuthState,
        //         Widget? child) {
        //       switch (firebaseAuthState.firebaseAuthStatus) {
        //         case FirebaseAuthStatus.signout:
        //           return AuthScreen();
        //         case FirebaseAuthStatus.progress:
        //           return y_ProgressIndicator();
        //         case FirebaseAuthStatus.signin:
        //           return HomePage();
        //         default:
        //           return y_ProgressIndicator();
        //       }
        //     },
        //     child: HomePage()),
        home: HomePage(),
        theme: ThemeData(primarySwatch: y_white),
      ),
    );
  }
}
