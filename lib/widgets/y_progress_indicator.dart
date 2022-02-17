import 'package:flutter/material.dart';

class y_ProgressIndicator extends StatelessWidget {
  final double? containerSize;
  final double? progressSize;

// this.progressSize = 60 으로 주면 초기값은 60으로 잡히지만 다른곳에서 설정을 progressSize = 70이라고 잡아주면 70이 적용됨.
  const y_ProgressIndicator(
      {Key? key, this.containerSize, this.progressSize = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      child: Center(
        child: SizedBox(
            width: progressSize,
            height: progressSize,
            child: Image.asset('assets/images/y_loading_img.gif')),
      ),
    );
  }
}
