import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bottom_navigationbar/widgets/rounded_avatar.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<bool> followings = List.generate(30, (index) => false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: RoundedAvatar(
                  size: 55,
                ),
                title: Text(
                  'userName $index',
                ),
                subtitle: Text('user bio number $index'),
                trailing: InkWell(
                  onTap: () {
                    setState(() {
                      followings[index] = !followings[index];
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                        color: followings[index]
                            ? Colors.redAccent[100]
                            : Colors.indigoAccent[100],
                        border: Border.all(
                            color: followings[index]
                                ? Colors.redAccent
                                : Colors.indigoAccent,
                            width: 0.5),
                        borderRadius: BorderRadius.circular(9)),
                    child: Text(
                      'following',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
            itemCount: followings.length));
  }
}
