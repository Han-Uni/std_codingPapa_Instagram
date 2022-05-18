import 'package:flutter/material.dart';

void simpleSnackbar(BuildContext context, String s) {
  SnackBar snackBar = SnackBar(
    content: Text(s),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {},
    ),
  );
}
