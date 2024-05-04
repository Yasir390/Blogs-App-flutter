import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/snackbar_message.dart';

class ForgotPassModel with ChangeNotifier{

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool loadingValue) {
    _loading = loadingValue;
    notifyListeners();
  }

  final formkey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> resetPassword(BuildContext context) async {
    setLoading(true);
    await firebaseAuth
        .sendPasswordResetEmail(
        email: mailController.text.trim())
        .then((value) {
      setLoading(false);
      SnackbarMessage().snackbarMessage(
          context, 'Mail sent', ContentType.success);
    }).onError((error, stackTrace) {
      setLoading(false);
      SnackbarMessage().snackbarMessage(
          context, error.toString(), ContentType.warning);
    });
  }
}