import 'package:flutter/material.dart';

extension SnackbarExtension on BuildContext {
  void showSnackbarMessage({required String message, bool? isError}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: isError == true
              ? Theme.of(this).errorColor
              : Theme.of(this).snackBarTheme.backgroundColor,
          content: Text(message),
        ),
      );
  }
}
