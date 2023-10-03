// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Const/Text.dart';
import 'package:to_do_app/Screens/AuthScreen/SignUpScreen.dart';
import 'package:to_do_app/Screens/HomeScreen/HomeScreen.dart';
import 'package:to_do_app/Utils/Decorations/TextformFieldDecoration.dart';
import 'package:to_do_app/Const/Colors.dart';
import 'package:to_do_app/Utils/Helper/helper.dart';
import 'package:to_do_app/Widget/Buttons/RoundButton.dart';
import 'package:form_validator/form_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final emailcontroller = TextEditingController();
  final passwordcontoller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontoller.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() {
      loading = true;
    });
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: emailcontroller.text.toString().trim(),
        password: passwordcontoller.text.toString().trim(),
      )
          .then((value) {
        setState(() {
          loading = false;
        });
        nHelpper().nsuccesstoast(context, 'Login');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
      nHelpper().nerrortoast(context, e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                nlogin,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: nColors.primarycolor),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailcontroller,
                      decoration:
                          nTextFormFieldDecoration.nTextFormFielsDeco.copyWith(
                        hintText: 'Email',
                        prefixIcon: const Icon(
                          CupertinoIcons.mail,
                          color: nColors.primarycolor,
                        ),
                      ),
                      onTapOutside: nHelpper().hidekeybord,
                      validator: ValidationBuilder().required().email().build(),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordcontoller,
                      decoration:
                          nTextFormFieldDecoration.nTextFormFielsDeco.copyWith(
                        hintText: 'Password',
                        prefixIcon: const Icon(
                          CupertinoIcons.lock_circle,
                          color: nColors.primarycolor,
                        ),
                      ),
                      onTapOutside: nHelpper().hidekeybord,
                      validator:
                          ValidationBuilder().required().minLength(6).build(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    nForgotpass,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: nColors.linkcolor,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              RoundButton(
                loading: loading,
                buttonname: 'Login',
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    login();
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ndonotaccount,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: Text(
                      nsignup,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: nColors.linkcolor,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
