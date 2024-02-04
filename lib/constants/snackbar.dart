import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String content, [snackColor = Colors.teal]) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: snackColor,
      showCloseIcon: true,
      duration: const Duration(milliseconds: 1),
    ),
  );
}
