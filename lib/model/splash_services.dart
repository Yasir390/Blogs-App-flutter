import 'dart:async';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/options_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashServices{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void isLogin(BuildContext context){

    if(_firebaseAuth.currentUser != null){

      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, HomeScreen.routeName);
      });
    }else{
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, OptionsScreen.routeName);
      });
    }

  }
}