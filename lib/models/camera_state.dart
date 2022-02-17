import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

// changeNotifierProvider를 통해서 데이터를 전달받는것임.
class CameraState extends ChangeNotifier {
  CameraController? _controller;
  CameraDescription? _cameraDescription;
  // cameraController가 initialize되었을때 준비되었다고 할 것임. 초기값은 false로 줄 것.
  bool _readyTakePhoto = false;

  void dispose() {
    if (_controller != null) {
      _controller!.dispose();
      _controller = null;
      _cameraDescription = null;
      _readyTakePhoto = false;
      notifyListeners();
    }
  }

  void printLog() {
    log('### y_log : camera_state.dart_testLog 333');
  }

  void getReadyToTakePhoto() async {
    List<CameraDescription> cameras = await availableCameras();
    // if(cameras != null && cameras.isNotEmpty)

    //bool checkTest = true;
    //if (checkTest) {}
    log('### y_log : bool 값 테스트입니다 isNotEmpty - ${cameras.isNotEmpty}');
    log('### y_log : bool 값 테스트입니다 isEmpty - ${cameras.isEmpty}');

    if (cameras.isNotEmpty) {
      log('### y_log : if true 값으로 들어옵니다');
      setCameraDescription(cameras[0]);
    } else {
      log("y_log : else 자리 : " + _controller.toString());
    }
    //cameras ?? setCameraDescription(cameras[0]);

    // initialize()가 실패할 수 있으니 init을 bool값으로 주고 돌려서 true로 변경하게끔 만들기
    bool init = false;
    // return true; 가 나올때 까지 실행하기
    while (!init) {
      log('### y_log : init안으로 들어오나요? ${!init}');
      init = await initialize();
      log('### y_log : init initialize 되었는지 확인 $init');
    }
    _readyTakePhoto = true;
    log('### y_log : readyTakePhoto 확인!!! $_readyTakePhoto');

    //changeNotifier를 통해서 데이터를 전달해 주는 과정에서 Consumer나 provider.of()를 통해서 상태를 확인하는 위젯들은
    // notifyListeners()를 데이터변화에 따른 디스플레이를 업데이트 해줘라 라는 알람을 받게 됨.
    notifyListeners();
  }

  void setCameraDescription(CameraDescription cameraDescription) {
    _cameraDescription = cameraDescription;
    // ResolutionPreset.medium : 화질은 중간화질로 나타내라
    _controller =
        CameraController(_cameraDescription!, ResolutionPreset.medium);
  }

  Future<bool> initialize() async {
    try {
      await _controller!.initialize();
      log('${_controller.toString()}');
      return true;
    } catch (e) {
      log('catch 오류로 발생합니다.');
      return false;
    }
  }

  // 해주는 이유 : 상단 CameraState클래스에 선언된 값들을 접근해서 값 변경이 될까봐, 접근해서 상단 클래스에 선언된 변수들을 못건들게
  CameraController? get controller => _controller;
  CameraDescription? get description => _cameraDescription;
  bool get isReadyToTakePhoto => _readyTakePhoto;
}

//  
