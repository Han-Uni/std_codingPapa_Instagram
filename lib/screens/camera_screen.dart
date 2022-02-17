import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bottom_navigationbar/models/camera_state.dart';
import 'package:flutter_bottom_navigationbar/widgets/my_gallery.dart';
import 'package:flutter_bottom_navigationbar/widgets/take_photo.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  CameraState _cameraState = CameraState();

  CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() {
    _cameraState.getReadyToTakePhoto();
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  // 현재 페이지 시작점을 나타냄. 시작점을 변경하면 시작점부터 페이지가 보임.
  // e.g. _currentIndex = 1 : bottomNavBar가 '사진'으로 선택됨.
  int _currentIndex = 0;
  // pageController에 initialPage를 설정해주면 설정된 페이지가 보임.
  // e.g. initialPage = 1 : 페이지 내용이 '사진'으로 선택됨.
  final PageController _pageController = PageController(initialPage: 0);
  // _title을 받아서 전달해주기 때문에 처음에 보여질 페이지의 이름을 설정해주면 됨.
  String _title = '갤러리';

  @override
  // 생성해준걸 없애지 않으면 리소스를 많이 먹음.
  void dispose() {
    _pageController.dispose();
    widget._cameraState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('y_log : camera_screen.dart_build 11111');
    log('y_log : camera_screen.dart_build ${widget._cameraState}');
    return MultiProvider(
      providers: [
        // getReadyToPhoto를 실행하기 위해서 value 값으로 던져줌.
        // 여러개의 provider전달은 가능하지만 타입은 한가지만 받을 수 있다.
        // 위의 provider를 주는 이유는 getReadyToTakePhoto를 실행을 미리 하기 위해서
        ChangeNotifierProvider<CameraState>.value(value: widget._cameraState),
        //아래로 써도 된다고 함.
        //ChangeNotifierProvider<CameraState>(create: (context) => CameraState())
      ],
      child: Scaffold(
        appBar: AppBar(
            // navigator.of(context).push로 들어왔기 때문에 Stack으로 들어와서 메인 위에 페이지가 띄워짐.
            // 그래서 앱바에 뒤로가기(<) 아이콘이 생김.
            // automaticallyImplyLeading : false 설정해주면 뒤로가기 아이콘이 사라짐.
            title: Text(
              _title,
              style: TextStyle(fontSize: 17),
            ),
            // appBar title을 가운데가 아닌 왼쪽 정렬로 만듬.
            centerTitle: false,
            // 기본 생성된 앱바 아이콘, onPressed 설정하기
            leading: IconButton(
              icon: Icon(
                Icons.clear_rounded,
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
              // _currentIndex로 앱바 title을 변경해 줄 수 있음.
              switch (_currentIndex) {
                case 0:
                  _title = '갤러리';
                  break;
                case 1:
                  _title = '사진';
                  break;
                case 2:
                  _title = '동영상';
                  break;
              }
            });
          },
          children: <Widget>[
            MyGallery(),
            TakePhoto(),
            Container(
              color: Colors.lightGreenAccent,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          iconSize: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: '갤러리',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: '사진',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: '동영상',
            ),
          ],
          currentIndex: _currentIndex,
          onTap: _onItemTabbed,
        ),
      ),
    );
  }

  void _onItemTabbed(index) {
    print(index);
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    });
  }
}
