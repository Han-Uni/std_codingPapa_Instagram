import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/constants/matrial_white.dart';
import 'package:flutter_bottom_navigationbar/home_page.dart';
import 'package:flutter_bottom_navigationbar/models/firebase_auth_state.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/User_model.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model_state.dart';
import 'package:flutter_bottom_navigationbar/repo/user_network_repository.dart';
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
  late Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    MultiProvider(providers: [
      ChangeNotifierProvider<FirebaseAuthState>.value(
          value: _firebaseAuthState),
      ChangeNotifierProvider<UserModelState>(
        create: (_) => UserModelState(),
      )
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthState>.value(
            value: _firebaseAuthState),
        ChangeNotifierProvider<UserModelState>(
          create: (_) => UserModelState(),
        )
      ],
      child: MaterialApp(
        //home: AuthScreen(),
        home: Consumer<FirebaseAuthState>(
          builder: (BuildContext context, FirebaseAuthState firebaseAuthState,
              Widget? child) {
            switch (firebaseAuthState.firebaseAuthStatus) {
              case FirebaseAuthStatus.signout:
                _clearUserModel(context);
                _currentWidget = AuthScreen();
                break;
              case FirebaseAuthStatus.signin:
                _initUserModel(firebaseAuthState, context);

                _currentWidget = HomePage();
                break;
              default:
                _currentWidget = y_ProgressIndicator();
            }
            return AnimatedSwitcher(
              // duration : 애니메이션을 얼마동안 실행할 것인지 시간 넣어주기
              duration: Duration(milliseconds: 300),
              child: _currentWidget,
            );
          },
        ),
        //home: HomePage(),
        theme: ThemeData(primarySwatch: y_white),
      ),
    );
  }

  void _initUserModel(
      FirebaseAuthState firebaseAuthState, BuildContext context) {
    UserModelState userModelState =
        Provider.of<UserModelState>(context, listen: false);

    userModelState.currentStreamSub = userNetworkRepository
        .getUserModelStream(firebaseAuthState.user.uid)
        .listen((userModel) {
      userModelState.userModel = userModel;
      // listen: false 이유 : UserModelState에서 userModel이 변경될 때마다 notifyListener를 해줘서 변경해주기 때문에 여기서 listen: flase로 해줘야함.
      // listen: true 기본값.
      //Provider.of<UserModelState>(context, listen: false).userModel = userModel;
    });
  }

  void _clearUserModel(BuildContext context) {
    UserModelState userModelState =
        Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }
}
