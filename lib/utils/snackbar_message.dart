import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SnackbarMessage{

  void snackbarMessage(context,msg,ContentType contentType){
        final snackBar = SnackBar(
          elevation: 0,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,

          content: AwesomeSnackbarContent(
            title: 'Account Creation',
            message:msg,
            contentType: contentType,

          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
  }
}
