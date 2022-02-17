import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bottom_navigationbar/constants/screen_size.dart';
import 'package:flutter_bottom_navigationbar/models/camera_state.dart';
import 'package:flutter_bottom_navigationbar/widgets/y_progress_indicator.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key? key,
  }) : super(key: key);

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  Widget _progress = y_ProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(
      builder: (BuildContext context, CameraState cameraState, Widget? child) {
        return Column(
          children: <Widget>[
            Container(
                color: Colors.indigoAccent,
                width: size?.width,
                height: size?.width,
                child: (cameraState.isReadyToTakePhoto)
                    ? _getPreview(cameraState)
                    : _progress
                // ? _progress
                // : //Text(' take_photo.dart Log!!! \n cameraState 값 확인!!! : $cameraState \n child Widget 값 확인!!! : $child \n BuildContext 값 확인!!! : $context')
                // _getPreview(cameraState),
                ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  OutlinedButton(
                    onPressed: () {
                      print('cameraButton 눌림!!!!');
                    },
                    child: Text(''),
                    style: OutlinedButton.styleFrom(
                        minimumSize: Size.fromRadius(40),
                        side:
                            BorderSide(width: 15, color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(200)))),
                  ),
                  Expanded(child: Container())
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getPreview(CameraState cameraState) {
    return ClipRect(
        // OverflowBox : 카메라 비율대로 맞춰놓은 사이즈를 밖에 흘러넘치게 해둠.
        child: OverflowBox(
      alignment: Alignment.center,
      //FittedBox : 가로길이에 알맞게 맞춰주는 용도
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Container(
          width: size!.width,
          // _controller!.value.aspectRatio : 현재 카메라의 비율대로 맞추려고 지정함.
          height: size!.width * cameraState.controller!.value.aspectRatio,
          child: CameraPreview(cameraState.controller!),
          // Text('### cameraState instance 확인 : ' +
          //     cameraState.toString() +
          //     '\n ### cameraState.isReadyToTakePhoto 확인 : ' +
          //     cameraState.isReadyToTakePhoto.toString() +
          //     '\n ### cameraState.controller 확인 : ' +
          //     cameraState.controller.toString() +
          //     '\n ### cameraState.description 확인 : ' +
          //     cameraState.description.toString())),
        ),
      ),
    ));
  }
}
