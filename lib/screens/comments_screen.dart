import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/constants/common_size.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController _textEditingController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            color: Colors.amber,
          )),
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: common_gap),
                child: TextFormField(
                  controller: _textEditingController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: 'Add a commnet...', border: InputBorder.none),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //todo push a comments
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
