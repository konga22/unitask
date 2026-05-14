import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Theme.of(this).colorScheme.error : null,
        content: Text(message),
      ),
    );
  }
}
