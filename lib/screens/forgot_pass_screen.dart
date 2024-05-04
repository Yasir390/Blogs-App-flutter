import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:blog_app/model/forgot_pass_model.dart';
import 'package:blog_app/utils/snackbar_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/resusable_button.dart';
import '../components/reusable_text_form_field.dart';
import '../model/login_model.dart';

class ForgetPassword extends StatefulWidget {
  static const String routeName = '/forgetPasScreen';

  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Consumer<ForgotPassModel>(
          builder: (BuildContext context, forgotPassProvider, Widget? child) {
            return Form(
              key: forgotPassProvider.formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Enter mail',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    ReusableTextFormField(
                      hintText: 'Enter Mail',
                      controller: forgotPassProvider.mailController,
                      onChanged: (value) {
                        //email = value;
                      },
                      iconName: Icons.mail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return value!.isEmpty ? 'Enter Email':null;
                      },
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                    ),
                    ReusableButton(
                      title: 'Reset Password',
                      loading:forgotPassProvider.loading,
                      onPressed: () async {
                        if (forgotPassProvider.formkey.currentState!.validate()) {
                          forgotPassProvider.resetPassword(context);
                        }
                      },
                    )
                  ],
                )
              ),
            );
          },

        ),
      ),
    );
  }
}
