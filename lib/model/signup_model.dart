import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:blog_app/utils/snackbar_message.dart';
import 'package:blog_app/utils/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupModel with ChangeNotifier {

  bool loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void setLoading(bool value){
    loading = value;
    notifyListeners();
  }

  void clearController(){
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signup(email,password,context) {
    try {
      setLoading(true);
      _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password,)
          .then((value) {
        setLoading(false);
          //ToastMessage().toastMessage('Account Created');
        SnackbarMessage().snackbarMessage(context, 'Successful',ContentType.success);
        clearController();
      }).onError((error, stackTrace) {
        setLoading(false);
        //ToastMessage().toastMessage(error.toString());
        SnackbarMessage().snackbarMessage(context, error.toString(),ContentType.warning);
      });
    } catch (e) {
      setLoading(false);
      //ToastMessage().toastMessage(e.toString());
      SnackbarMessage().snackbarMessage(context, e.toString(),ContentType.warning);
    }
  }
}