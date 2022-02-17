import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigationbar/constants/common_size.dart';

InputDecoration textInputDecor(String text) {
  return InputDecoration(
    fillColor: Colors.grey[100],
    filled: true,
    hintText: text,
    enabledBorder: activeInputBorder(),
    focusedBorder: activeInputBorder(),
    errorBorder: errorInputBorder(),
    focusedErrorBorder: errorInputBorder(),
  );
}

OutlineInputBorder errorInputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red.shade500,
    ),
    borderRadius: BorderRadius.circular(common_xxs_gap),
  );
}

OutlineInputBorder activeInputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.shade500,
    ),
    borderRadius: BorderRadius.circular(common_xxs_gap),
  );
}
