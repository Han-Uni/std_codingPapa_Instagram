import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/widgets/post.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: IconButton(
          onPressed: null,
          icon: Icon(
            CupertinoIcons.camera,
            color: Colors.black87,
          ),
        ),
        middle: Text(
          'Instagram',
          style: TextStyle(fontFamily: 'VeganStyle', color: Colors.black),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            IconButton(
              onPressed: null,
              icon: ImageIcon(AssetImage('assets/images/actionbar_camera.png')),
              color: Colors.black87,
            ),
            IconButton(
              onPressed: null,
              icon: ImageIcon(AssetImage('assets/images/actionbar_camera.png')),
              color: Colors.black,
            ),
          ],
        ),
      ),
      body:
          // ListView.builder(
          //   itemBuilder: feedListBuilder,
          //   itemCount: 30,
          // )

          ListView.builder(itemBuilder: (BuildContext context, int index) {
        return
            // Image.network(
            //     'https://images.unsplash.com/photo-1494253109108-2e30c049369b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwZm9vZCUyMHN0b3JlfGVufDB8fDB8fA%3D%3D&w=1000&q=80');
            Post(index);
      }),
    );
  }

  Widget feedListBuilder(BuildContext context, int index) {
    return Container(
        color: Colors.accents[index % Colors.accents.length],
        height: 100,
        child: Image.network(
            'https://images.unsplash.com/photo-1494253109108-2e30c049369b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwZm9vZCUyMHN0b3JlfGVufDB8fDB8fA%3D%3D&w=1000&q=80'));
  }
}
