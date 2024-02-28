import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class ContentBar {

  static String message = '';
  static String title = 'Completed';

  static final errorBar = SnackBar(
    duration: const Duration(milliseconds: 700),
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Error',
      message: message,
      contentType: ContentType.failure,
    ),
  );

  static final successBar = SnackBar(
    duration: const Duration(milliseconds: 2000),
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.success,
    ),
  );

}