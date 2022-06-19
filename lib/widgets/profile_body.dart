import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bottom_navigationbar/constants/common_size.dart';
import 'package:flutter_bottom_navigationbar/constants/screen_size.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model_state.dart';
import 'package:flutter_bottom_navigationbar/screens/profile_screen.dart';
import 'package:flutter_bottom_navigationbar/widgets/rounded_avatar.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatefulWidget {
  final Function? onMenuChanged;

  const ProfileBody({Key? key, this.onMenuChanged}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with SingleTickerProviderStateMixin {
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size!.width;
  AnimationController? _iconAnimationController;

// 해당 state가 시작될 때 실행됨.
  @override
  void initState() {
    _iconAnimationController =
        AnimationController(vsync: this, duration: yDuration);
    super.initState();
  }

// 해당 state가 버려질 때 실행됨.
  @override
  void dispose() {
    _iconAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _appbar(),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(common_gap),
                          child: RoundedAvatar(
                            size: 100,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: common_gap),
                            child: Table(
                              children: [
                                TableRow(children: <Widget>[
                                  _valueText('1'),
                                  _valueText('85'),
                                  _valueText('124'),
                                ]),
                                TableRow(children: <Widget>[
                                  _labelText('게시물'),
                                  _labelText('팔로워'),
                                  _labelText('팔로잉'),
                                ])
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    _username(context),
                    _userBio(),
                    _editProfileBtn(),
                    _tapButtons(),
                    _selectedIndicator(),
                  ])),
                  _imagesPager()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: null,
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
        ),
        Expanded(
            child: Text(
          'sdfsdfsdf',
          textAlign: TextAlign.center,
        )),
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _iconAnimationController!,
          ),
          onPressed: () {
            // class ProfileBody에서 선언된 onMenuChanged를 접근하여 사용하려면 'widget.'을 사용해야함.
            widget.onMenuChanged!();
            _iconAnimationController!.status == AnimationStatus.completed
                // completed : forward가 시작해서 끝난거
                // dismissed : 처음지점으로 돌아오는거
                // forward : 시작에서 끝으로 가는 중간
                // reverse : 끝에서 시작점으로 가는 중간

                ? _iconAnimationController!.reverse()
                : _iconAnimationController!.forward();
          },
        )
      ],
    );
  }

  Text _valueText(String value) => Text(value,
      style: TextStyle(fontWeight: FontWeight.bold),
      textAlign: TextAlign.center);

  Text _labelText(String label) => Text(label,
      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
      textAlign: TextAlign.center);

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
      child: Stack(children: <Widget>[
        AnimatedContainer(
          // 애니메이션 지속 시간? 설정해주기 / milliseconds : 1000 = 1초
          duration: yDuration,
          // x축을 이용하여 위치 전환해주기
          transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
          // curve : 애니메이션 효과
          curve: Curves.fastOutSlowIn,
          child: _images(),
        ),
        AnimatedContainer(
          // 애니메이션 지속 시간? 설정해주기 / milliseconds : 1000 = 1초
          duration: yDuration,
          // x축을 이용하여 위치 전환해주기
          transform: Matrix4.translationValues(_rightImagesPageMargin, 0, 0),
          // curve : 애니메이션 효과
          curve: Curves.fastOutSlowIn,
          child: _images(),
        ),
      ]),
    );
  }

  GridView _images() {
    return GridView.count(
      // scroll을 사용할 수 있는지 없는지??? / NeverScrollableScrollPhysics = 위 부모인 customScrollView에서도 스크롤 가능, 현재 GridView에서도 스크롤 가능하니까 둘중 하나만 스크롤 할 수 있게 gridView에서는 스크롤을 막음.
      physics: NeverScrollableScrollPhysics(),
      // crossAxisCount : 크로스 축에 몇개를 보여줄건지 / 3개를 보여주려고 3이라고 지정함.
      crossAxisCount: 3,
      // childAspectRatio : 사진 비율 정하기 / 1:1이라서 1로 지정해줌.
      childAspectRatio: 1,
      // shrinkWrap : 기본값=false / false = 해당영역 + 나머지부분 보여줌, true = 해당영역만 보여줌.
      shrinkWrap: true,

      children: List.generate(
          30,
          (index) => CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: "https://picsum.photos/id/$index/100/100")),
    );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: yDuration,
      alignment: _selectedTab == SelectedTab.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        width: size!.width / 2,
        height: 1,
        color: Colors.black,
      ),
      curve: Curves.linearToEaseOut,
    );
  }

  Row _tapButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconButton(
              onPressed: () {
                _tabSelected(SelectedTab.left);
              },
              icon: ImageIcon(
                AssetImage('assets/images/instagram_grid.png'),
                color: _selectedTab == SelectedTab.left
                    ? Colors.black
                    : Colors.black26,
              )),
        ),
        Expanded(
          child: IconButton(
              onPressed: () {
                _tabSelected(SelectedTab.right);
              },
              icon: ImageIcon(
                AssetImage('assets/images/saved.png'),
                color: _selectedTab == SelectedTab.left
                    ? Colors.black26
                    : Colors.black,
              )),
        ),
      ],
    );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.left:
          _selectedTab = SelectedTab.left;
          _leftImagesPageMargin = 0;
          _rightImagesPageMargin = size!.width;

          break;
        case SelectedTab.right:
          _selectedTab = SelectedTab.right;
          _leftImagesPageMargin = -size!.width;
          _rightImagesPageMargin = 0;

          break;
      }
    });
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: SizedBox(
        height: 27,
        child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                )),
            child: Text(
              '프로필 편집',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }

  Widget _userBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'i am really hungry!!!',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _username(BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context);
    //var userModel = Provider.of<UserModelState>(context).userModel;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        userModelState == null || userModelState.userModel == null
            ? ""
            : userModelState.userModel.username,

        //Provider.of<UserModelState>(context).userModel.username,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

enum SelectedTab { left, right }
