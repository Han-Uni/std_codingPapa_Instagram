import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bottom_navigationbar/constants/auth_input_decor.dart';
import 'package:flutter_bottom_navigationbar/constants/common_size.dart';
import 'package:flutter_bottom_navigationbar/home_page.dart';
import 'package:flutter_bottom_navigationbar/models/firebase_auth_state.dart';
import 'package:flutter_bottom_navigationbar/widgets/or_divider.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // _formKey : 하단 위젯 Form의 상태를 저장하는 key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_xl_gap),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: common_l_gap,
                ),
                Image.asset('assets/images/insta_text_logo.png'),
                TextFormField(
                  // 커서 색상 맞추기
                  cursorColor: Colors.black45,
                  controller: _emailController,
                  decoration: textInputDecor('전화번호 이메일 주소 또는 사용자 이름'),
                  validator: (text) {
                    if (text!.isNotEmpty && text.contains("@")) {
                      return null;
                    } else {
                      return '이메일 형식에 맞게 작성하세요.';
                    }
                  },
                ),
                SizedBox(
                  height: common_s_gap,
                ),
                TextFormField(
                  cursorColor: Colors.black45,
                  // 비밀번호 문자 감추기
                  obscureText: true,
                  controller: _pwController,
                  decoration: textInputDecor('비밀번호'),
                  validator: (text) {
                    if (text!.isNotEmpty && text.length > 5) {
                      return null;
                    } else {
                      return '비밀번호를 6글자 이상 입력하세요.';
                    }
                  },
                ),
                SizedBox(
                  height: common_s_gap,
                ),
                TextFormField(
                  cursorColor: Colors.black45,
                  controller: _cpwController,
                  decoration: textInputDecor('확인비밀번호'),
                  validator: (text) {
                    if (text!.isNotEmpty && _pwController.text == text) {
                      return null;
                    } else {
                      return '비밀번호가 일치하지 않습니다.';
                    }
                  },
                ),
                SizedBox(height: common_s_gap),
                _submitButton(context),
                SizedBox(height: common_xl_gap),
                OrDivider(),
                SizedBox(height: common_xl_gap),
                TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.blueAccent),
                  onPressed: () {
                    Provider.of<FirebaseAuthState>(context, listen: false)
                        .changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
                  },
                  icon: ImageIcon(AssetImage("assets/images/facebook.png")),
                  label: Text('Facebook으로 로그인'),
                )
              ],
            )),
      ),
    );
  }

  Container _submitButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueAccent,
          border: Border.all(width: 1, color: Color(0x00ffffff)),
          borderRadius: BorderRadius.circular(common_xxs_gap)),
      child: TextButton(
        onPressed: () {
          // 위의 validator 부분이 다 null로 들어와서 True가 되면 아래 유효성검사 성공 메세지가 뜸.
          if (_formKey.currentState!.validate()) {
            print("유효성 검사 성공 !!!");
            Provider.of<FirebaseAuthState>(context, listen: false).registerUser(
                context,
                email: _emailController.text,
                password: _pwController.text);
          }
        },
        child: Text(
          '가입하기',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
