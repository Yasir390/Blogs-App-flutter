import 'package:blog_app/components/resusable_button.dart';
import 'package:blog_app/model/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/reusable_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signupScreen';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formkey = GlobalKey<FormState>();
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<SignupModel>(
              builder: (BuildContext context, signupProvider, Widget? child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Register',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    ReusableTextFormField(
                      hintText: 'Enter Mail',
                      controller: signupProvider.emailController,
                      onChanged: (value) {
                        email = value;
                      },
                      iconName: Icons.mail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return value!.isEmpty ? 'Enter Email':null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    ReusableTextFormField(
                      hintText: 'Enter Password',
                      controller: signupProvider.passwordController,
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      iconName: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        return value!.isEmpty ? 'Enter Password':null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                    ),
                    ReusableButton(
                      title: 'Register',
                      loading:signupProvider.loading,
                      onPressed: () {
                        if(_formkey.currentState!.validate()){
                          signupProvider.signup(signupProvider.emailController.text.trim(),
                              signupProvider.passwordController.text.trim(),context);
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
