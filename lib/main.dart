import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/constants/matrial_white.dart';
import 'package:flutter_bottom_navigationbar/home_page.dart';
import 'package:flutter_bottom_navigationbar/screens/auth_screen.dart';

main() {
  runApp(BtmNavBar());
}

class BtmNavBar extends StatefulWidget {
  const BtmNavBar({Key? key}) : super(key: key);

  @override
  _BtmNavBarState createState() => _BtmNavBarState();
}

class _BtmNavBarState extends State<BtmNavBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: y_white),
      //home: AuthScreen(),
      home: HomePage(),
    );
  }
}
