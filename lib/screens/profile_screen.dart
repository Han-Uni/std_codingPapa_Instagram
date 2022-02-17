import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bottom_navigationbar/constants/screen_size.dart';
import 'package:flutter_bottom_navigationbar/widgets/profile_body.dart';
import 'package:flutter_bottom_navigationbar/widgets/profile_side_menu.dart';

// 클래스 밖에 선언된 변수는 Static이다.
const yDuration = Duration(milliseconds: 300);

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({Key? key}) : super(key: key);

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  final menuWidth = size!.width / 2;

  double bodyXPos = 0;

  double menuXPos = size!.width;

  MenuStatus _menuStatus = MenuStatus.closed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
              duration: yDuration,
              curve: Curves.fastOutSlowIn,
              transform: Matrix4.translationValues(bodyXPos, 0, 0),
              // ProfileBody 클래스에서 만든 Function onMenuChanged:(){} 를 사용할 수 있다.
              child: ProfileBody(onMenuChanged: () {
                setState(() {
                  _menuStatus = (_menuStatus == MenuStatus.closed)
                      ? MenuStatus.opend
                      : MenuStatus.closed;
                  print(_menuStatus);
                  switch (_menuStatus) {
                    case MenuStatus.opend:
                      print('opend');
                      bodyXPos = -menuWidth;
                      menuXPos = size!.width - menuWidth;
                      break;
                    case MenuStatus.closed:
                      print('closed');
                      bodyXPos = 0;
                      menuXPos = size!.width;
                      break;
                  }
                });
              })),
          AnimatedContainer(
            duration: yDuration,
            curve: Curves.fastOutSlowIn,

            transform: Matrix4.translationValues(menuXPos, 0, 0),
            // positioned는 Stack아래에서 사용한다.
            // 여기에서는 positined를 삭제해줘도 앱 돌아가는거에 대해서는 무방함.
            child: Positioned(
              // top : Stack의 위에서 얼마나 떨어져있는지 확인.
              top: 0,
              // bottom : Stack의 아래에서 얼마나 떨어져있는지 체크.
              bottom: 0,
              width: menuWidth,
              child: ProfileSideMenu(menuWidth),
            ),
          ),
        ],
      ),
    );
  }
}

enum MenuStatus { opend, closed }
