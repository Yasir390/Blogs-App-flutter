import 'package:blog_app/model/forgot_pass_model.dart';
import 'package:blog_app/model/login_model.dart';
import 'package:blog_app/model/post_model.dart';
import 'package:blog_app/model/search_controller_model.dart';
import 'package:blog_app/model/signup_model.dart';
import 'package:blog_app/model/update_post_model.dart';
import 'package:blog_app/screens/forgot_pass_screen.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/login_screen.dart';
import 'package:blog_app/screens/options_screen.dart';
import 'package:blog_app/screens/post_screen.dart';
import 'package:blog_app/screens/signup_screen.dart';
import 'package:blog_app/screens/splash_screen.dart';
import 'package:blog_app/screens/update_post.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
       MultiProvider(providers: [
         ChangeNotifierProvider(create: (context) => SignupModel(),),
         ChangeNotifierProvider(create: (context) => LoginModel(),),
         ChangeNotifierProvider(create: (context) => PostModel(),),
         ChangeNotifierProvider(create: (context) => ForgotPassModel(),),
         ChangeNotifierProvider(create: (context) => SearchControllerModel(),),
         ChangeNotifierProvider(create: (context) => UpdatePostModel(),),
       ],
       child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        OptionsScreen.routeName : (context) => const OptionsScreen(),
        SignupScreen.routeName : (context) => const SignupScreen(),
        LoginScreen.routeName : (context) => const LoginScreen(),
        HomeScreen.routeName : (context) => const HomeScreen(),
        SplashScreen.routeName : (context) => const SplashScreen(),
        PostScreen.routeName : (context) => const PostScreen(),
        ForgetPassword.routeName : (context) => const ForgetPassword(),
        UpdatePost.routeName : (context) =>  UpdatePost(),
      },
    );
  }
}

