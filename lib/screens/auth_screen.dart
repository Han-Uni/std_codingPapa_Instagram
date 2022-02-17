import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bottom_navigationbar/widgets/fade_stack.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int selectedForm = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드가 올라왔을 때 화면이 resized되며 위젯이 키보드 위로 올라오는것. 기본값은 true임.
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FadeStack(
              selectedForm: selectedForm,
            ),
            // stack 아래에 사용할 수 있는 Positioned. 아래 위젯에 위치를 조정해 줄 수 있다. / 아래같은경우 왼쪽, 오른쪽, 아래에 0만큼을 주고 붙으라는 얘기.
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                // border 주는 방법. Container()-decoration-BoxDecoration()-border-Border()'로 줄 수 있다.
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey))),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      // currentWidget is SignUpForm
                      // instance is Class 형식으로 if문 안에서 is를 사용한다.
                      // NOTION - flutter - 강의 36AnimatedSwitcher에 정리해둠.
                      if (selectedForm == 0) {
                        selectedForm = 1;
                      } else {
                        selectedForm = 0;
                      }
                    });
                  },
                  // RichText : 다양한 텍스트 스타일이 혼합된 텍스트를 사용할 때 쓰임. children으로 list를 받아 글씨를 이어갈 수 있다.
                  child: RichText(
                    text: TextSpan(
                        text: (selectedForm == 0)
                            ? '계정이 없으신가요? '
                            : '이미 계정이 있으신가요? ',
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                              text: (selectedForm == 0) ? '가입하기.' : '로그인하기',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold)),
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
