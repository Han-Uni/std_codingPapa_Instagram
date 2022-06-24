import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model.dart';
import 'package:flutter_bottom_navigationbar/repo/user_network_repository.dart';
import 'package:flutter_bottom_navigationbar/widgets/rounded_avatar.dart';
import 'package:flutter_bottom_navigationbar/widgets/y_progress_indicator.dart';

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
        title: Text('Follow/UnFollow'),
        elevation: 1,
      ),
      body: StreamBuilder<List<UserModel>>(
          stream: userNetworkRepository.getAllUsersWithoutMe(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        UserModel userModel = snapshot.data![index];
                        return ListTile(
                          leading: RoundedAvatar(
                            size: 55,
                          ),
                          title: Text(userModel.username),
                          subtitle:
                              Text('this is user bio of ${userModel.username}'),
                          trailing: InkWell(
                            onTap: () {
                              setState(() {
                                // followings[index] = !followings[index];
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                  color:
                                      // followings[index] ? Colors.redAccent[100]:
                                      Colors.indigoAccent[100],
                                  border: Border.all(
                                      color:
                                          // followings[index] ? Colors.redAccent :
                                          Colors.indigoAccent,
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(9)),
                              child: Text(
                                'following',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                      itemCount: snapshot.data!.length));
            } else {
              return y_ProgressIndicator();
            }
          }),
    );
  }
}
