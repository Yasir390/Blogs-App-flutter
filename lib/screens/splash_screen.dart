import 'package:blog_app/model/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 final SplashServices _splashServices = SplashServices();

  @override
  void initState() {
    _splashServices.isLogin(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
