import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/constants/common_size.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/comment_model.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model.dart';
import 'package:flutter_bottom_navigationbar/models/firestore/user_model_state.dart';
import 'package:flutter_bottom_navigationbar/repo/comment_network_repository.dart';
import 'package:flutter_bottom_navigationbar/widgets/comment.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final String postKey;
  const CommentsScreen(this.postKey, {Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController _textEditingController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: StreamProvider<List<CommentModel>>.value(
                value:
                    commentNetworkRepository.fetchAllComments(widget.postKey),
                initialData: [],
                child: Consumer<List<CommentModel>>(
                  builder: (BuildContext context, List<CommentModel> comments,
                      Widget? child) {
                    return ListView.separated(
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(common_xs_gap),
                            child: Comment(
                              userName: comments[index].username,
                              text: comments[index].comment,
                              dateTime: comments[index].commentTime,
                              showImage: true,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: common_xxs_gap,
                          );
                        },
                        itemCount: comments == null ? 0 : comments.length);
                  },
                ),
              )),
              Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey[300],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: common_gap),
                    child: TextFormField(
                      controller: _textEditingController,
                      cursorColor: Colors.black,
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: 'Add a commnet...',
                          border: InputBorder.none),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Input Something';
                        } else {
                          return null;
                        }
                      },
                    ),
                  )),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        UserModel usermodel =
                            Provider.of<UserModelState>(context, listen: false)
                                .userModel;
                        Map<String, dynamic> newComment =
                            CommentModel.getMapForNewComment(
                                usermodel.userKey,
                                usermodel.username,
                                _textEditingController.text);
                        await commentNetworkRepository.createNewComment(
                            widget.postKey, newComment);
                        _textEditingController.clear();
                      }
                      ;
                    },
                    child: Text(
                      'POST',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
