import 'package:flutter/material.dart';

void showErrorSnack(BuildContext context, String errorMsg) {
  final snackbar = SnackBar(
    duration: Duration(seconds: 5),
    showCloseIcon: true,
    content: Text(errorMsg),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
