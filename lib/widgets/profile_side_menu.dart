import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/screens/auth_screen.dart';

class ProfileSideMenu extends StatelessWidget {
  final double menuWidth;
  // 중괄호 안에 넣어주면 옵션값이 됨. 넣어줘도 되고, 안넣어줘도 되고.
  // 밖으로 빼면 필수 값이 됨.
  const ProfileSideMenu(
    this.menuWidth, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: menuWidth,
        child: Column(
          children: <Widget>[
            ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.black87,
                ),
                title: Text('설정')),
            ListTile(
              leading: Icon(Icons.update_outlined, color: Colors.black87),
              title: Text('보관'),
            ),
            ListTile(
              leading: Icon(Icons.av_timer_outlined, color: Colors.black87),
              title: Text('내 활동'),
            ),
            ListTile(
              leading:
                  Icon(Icons.qr_code_scanner_outlined, color: Colors.black87),
              title: Text('QR코드'),
            ),
            ListTile(
              leading: Icon(Icons.bookmark_outline, color: Colors.black87),
              title: Text('저장됨'),
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted_outlined,
                  color: Colors.black87),
              title: Text('친한 친구'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AuthScreen()));
              },
              leading: Icon(Icons.logout_sharp, color: Colors.black87),
              title: Text('로그아웃'),
            ),
          ],
        ),
      ),
    );
  }
}
