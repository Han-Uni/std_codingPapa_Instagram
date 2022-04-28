import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/models/firebase_auth_state.dart';
import 'package:flutter_bottom_navigationbar/screens/auth_screen.dart';
import 'package:provider/provider.dart';

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
              title: Text('설정'),
              leading: Icon(
                Icons.settings,
                color: Colors.black87,
              ),
            ),
            ListTile(
              title: Text('보관'),
              leading: Icon(Icons.update_outlined, color: Colors.black87),
            ),
            ListTile(
              title: Text('내 활동'),
              leading: Icon(Icons.av_timer_outlined, color: Colors.black87),
            ),
            ListTile(
              title: Text('QR코드'),
              leading:
                  Icon(Icons.qr_code_scanner_outlined, color: Colors.black87),
            ),
            ListTile(
              title: Text('저장됨'),
              leading: Icon(Icons.bookmark_outline, color: Colors.black87),
            ),
            ListTile(
              title: Text('친한 친구'),
              leading: Icon(Icons.format_list_bulleted_outlined,
                  color: Colors.black87),
            ),
            ListTile(
              title: Text('로그아웃'),
              leading: Icon(Icons.logout_sharp, color: Colors.black87),
              onTap: () {
                Provider.of<FirebaseAuthState>(context, listen: false)
                    .changeFirebaseAuthStatus(FirebaseAuthStatus.signout);
              },
            ),
          ],
        ),
      ),
    );
  }
}
