import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_app/Const/Text.dart';
import 'package:to_do_app/Screens/AuthScreen/LoginScreen.dart';
import 'package:to_do_app/Utils/Decorations/TextformFieldDecoration.dart';
import 'package:to_do_app/Const/Colors.dart';
import 'package:to_do_app/Widget/Buttons/RoundButton.dart';
import 'package:form_validator/form_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontoller = TextEditingController();
  final namecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
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
                nsignup,
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
                      controller: namecontroller,
                      decoration:
                          nTextFormFieldDecoration.nTextFormFielsDeco.copyWith(
                        hintText: 'Name',
                        prefixIcon: const Icon(
                          CupertinoIcons.person,
                          color: nColors.primarycolor,
                        ),
                      ),
                      validator: ValidationBuilder().required().build(),
                    ),
                    const SizedBox(height: 10),
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
                buttonname: nsignup,
                onTap: () {
                  if (_formkey.currentState!.validate()) {}
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    nhaveaccount,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: Text(
                      nlogin,
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
