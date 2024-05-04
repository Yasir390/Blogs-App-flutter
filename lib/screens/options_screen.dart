import 'dart:async';

import 'package:blog_app/components/resusable_button.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/login_screen.dart';
import 'package:blog_app/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OptionsScreen extends StatefulWidget {
  static const String routeName = '/optionsScreen';

  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Blog App',
            style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.09,
            ),

            ReusableButton(
              title: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.06,
            ),

            ReusableButton(
              title: 'Signup',
              onPressed: () {
                Navigator.pushNamed(context, SignupScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
