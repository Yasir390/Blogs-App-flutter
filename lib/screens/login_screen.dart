import 'package:blog_app/model/login_model.dart';
import 'package:blog_app/screens/forgot_pass_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/resusable_button.dart';
import '../components/reusable_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/loginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<LoginModel>(
              builder: (BuildContext context, loginProvider, Widget? child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    ReusableTextFormField(
                      hintText: 'Enter Mail',
                      controller: loginProvider.emailController,
                      onChanged: (value) {
                        //email = value;
                      },
                      iconName: Icons.mail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return value!.isEmpty ? 'Enter Email' : null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    ReusableTextFormField(
                      hintText: 'Enter Password',
                      controller: loginProvider.passwordController,
                      obscureText: true,
                      onChanged: (value) {
                        //  password = value;
                      },
                      iconName: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        return value!.isEmpty ? 'Enter Password' : null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ForgetPassword.routeName);
                        },
                        child: const Text('Forget Password?',
                          style: TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    ReusableButton(
                      title: 'Login',
                      loading: loginProvider.loading,
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          loginProvider.login(
                              loginProvider.emailController.text.trim(),
                              loginProvider.passwordController.text.trim(),
                              context);
                        }
                      },
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
