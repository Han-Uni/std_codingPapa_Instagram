import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/widgets/sign_in_form.dart';
import 'package:flutter_bottom_navigationbar/widgets/sign_up_form.dart';

class FadeStack extends StatefulWidget {
  final int? selectedForm;
  const FadeStack({Key? key, this.selectedForm}) : super(key: key);

  @override
  _FadeStackState createState() => _FadeStackState();
}

class _FadeStackState extends State<FadeStack>
    // animationController를 사용하기 위해서 필요한 것. 한개의 애니메이션을 실행할때 쓰나보다
    with
        SingleTickerProviderStateMixin {
  // 초기값을 지정해줘서 ?(null)을 기재 안해도 됨!
  List<Widget> signForms = [SignUpForm(), SignInForm()];
  AnimationController? _animationController;

  @override
  void initState() {
    // this : _AuthScreenState의 instance를 전달해줌.
    // 이유 : SingleTickerProviderStateMixin을 던져줘야함.
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationController!.forward();
    super.initState();
  }

  @override
  // didUpdateWidget : AuthScreen의 oldWidget을 던져줘서 현재위젯과 oldWidget을 비교해봄.
  void didUpdateWidget(covariant FadeStack oldWidget) {
    if (widget.selectedForm != oldWidget.selectedForm) {
      _animationController?.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController!,
      child: IndexedStack(
        index: widget.selectedForm,
        children: signForms,
      ),
    );
  }
}
