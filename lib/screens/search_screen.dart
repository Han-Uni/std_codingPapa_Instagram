import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bottom_navigationbar/models/firebase_auth_state.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model_state.dart';
import 'package:flutter_bottom_navigationbar/repo/user_network_repository.dart';
import 'package:flutter_bottom_navigationbar/widgets/rounded_avatar.dart';
import 'package:flutter_bottom_navigationbar/widgets/y_progress_indicator.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(''),
            Text('Follow/UnFollow'),
            GestureDetector(
                onTap: () {
                  Provider.of<FirebaseAuthState>(context, listen: false)
                      .signOut();
                },
                child: Icon(Icons.access_alarm))
          ],
        ),
        elevation: 1,
      ),
      body: StreamBuilder<List<UserModel>>(
          stream: userNetworkRepository.getAllUsersWithoutMe(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(child: Consumer<UserModelState>(builder:
                  (BuildContext context, UserModelState myUserModelState,
                      Widget? child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      UserModel otherUser = snapshot.data![index];
                      bool amIFollowing = myUserModelState
                          .amIFollwingThisUser(otherUser.userKey);
                      return ListTile(
                        leading: RoundedAvatar(
                          size: 55,
                        ),
                        title: Text(otherUser.username),
                        subtitle:
                            Text('this is user bio of ${otherUser.username}'),
                        trailing: InkWell(
                          onTap: () {
                            setState(() {
                              amIFollowing
                                  ? userNetworkRepository.unFollowUser(
                                      myUserKey:
                                          myUserModelState.userModel.userKey,
                                      otherUserKey: otherUser.userKey)
                                  : userNetworkRepository.followUser(
                                      myUserKey:
                                          myUserModelState.userModel.userKey,
                                      otherUserKey: otherUser.userKey);
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                color: amIFollowing
                                    ? Colors.indigoAccent[100]
                                    : Colors.redAccent[100],
                                border: Border.all(
                                    color: amIFollowing
                                        ? Colors.indigoAccent
                                        : Colors.redAccent,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(9)),
                            child: FittedBox(
                              child: Text(
                                amIFollowing ? 'following' : 'not following',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.grey[30],
                      );
                    },
                    itemCount: snapshot.data!.length);
              }));
            } else {
              return y_ProgressIndicator();
            }
          }),
    );
  }
}
