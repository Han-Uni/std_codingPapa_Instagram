import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
            left: 0,
            right: 0,
            height: 1,
            child: Container(
              color: Colors.grey[400],
              height: 1,
            )),
        Container(
          color: Colors.grey[50],
          height: 3,
          width: 60,
        ),
        Text(
          '또는',
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
