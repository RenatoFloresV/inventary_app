import 'package:flutter/material.dart';

SnackBar snackBarWhenFailure({required String snackBarFailureText}) {
  return SnackBar(
    content: Text(snackBarFailureText),
    backgroundColor: Colors.red,
  );
}

SnackBar snackBarWhenSuccess(String label) {
  return SnackBar(
    duration: const Duration(seconds: 1),
    content: Text(label),
    backgroundColor: Colors.green,
  );
}
