import 'dart:developer';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/constants/screen_size.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model_state.dart';
import 'package:flutter_bottom_navigationbar/screens/camera_screen.dart';
import 'package:flutter_bottom_navigationbar/screens/feed_screen.dart';
import 'package:flutter_bottom_navigationbar/screens/profile_screen.dart';
import 'package:flutter_bottom_navigationbar/screens/search_screen.dart';
import 'package:flutter_bottom_navigationbar/widgets/y_progress_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavBarItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'sdfsdf'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
  ];
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    Consumer<UserModelState>(builder:
        (BuildContext context, UserModelState userModelState, Widget? child) {
      if (userModelState == null ||
          userModelState.userModel.followings == null ||
          userModelState.userModel.followings.isEmpty) {
        return y_ProgressIndicator();
      } else
        return FeedScreen(userModelState.userModel.followings);
    }),
    SearchScreen(),
    Container(color: Colors.indigoAccent),
    Container(color: Colors.limeAccent),
    ProfileScreens(),
  ];

  @override
  Widget build(BuildContext context) {
    size ??= MediaQuery.of(context).size;
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: btmNavBarItem,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: btmItemClick,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  void btmItemClick(int index) {
    switch (index) {
      case 2:
        _openCamera();
        break;
      default:
        {
          setState(() {
            _selectedIndex = index;
          });
          print(index);
        }
    }
  }

  void _openCamera() async {
    if (await checkIfPermissionGranted(context)) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CameraScreen()));
    } else {
      SnackBar snackBar = SnackBar(
        content: Text('접근 허용해줘야 사용가능함.'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            AppSettings.openAppSettings();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.photos
    ].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) permitted = false;
    });

    return permitted;
  }
}
