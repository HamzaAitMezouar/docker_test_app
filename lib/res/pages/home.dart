// ignore_for_file: camel_case_types

import 'package:advancedproj/res/controller/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class home extends StatefulWidget {
  const home({
    Key? key,
  }) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  FirebaseSignInController firebaseSignInController =
      Get.put(FirebaseSignInController());
  bool haveAcount = true;
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  String email = '';
  String password = '';
  String name = '';
  @override
  void dispose() {
    emailcontroller.dispose();
    namecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Form(
                  key: _formkey,
                  child: haveAcount
                      ? Column(
                          children: [
                            SizedBox(height: size.height * 0.1),
                            emailWidget(size),
                            SizedBox(height: size.height * 0.1),
                            passwordWidget(size),
                            SizedBox(height: size.height * 0.1),
                            ElevatedButton.icon(
                                onPressed: () {
                                  if ((_formkey.currentState != null &&
                                      _formkey.currentState!.validate())) {
                                    print(email.toLowerCase());
                                  }
                                },
                                icon: const Icon(Icons.login),
                                label: const Text('Sign in '))
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(height: size.height * 0.1),
                            emailWidget(size),
                            SizedBox(height: size.height * 0.1),
                            passwordWidget(size),
                            SizedBox(height: size.height * 0.1),
                            nameWidget(size),
                            SizedBox(height: size.height * 0.1),
                            ElevatedButton.icon(
                                onPressed: () {
                                  if ((_formkey.currentState != null &&
                                      _formkey.currentState!.validate())) {
                                    firebaseSignInController.signUp(
                                        name, email, password);
                                  }
                                },
                                icon: const Icon(Icons.login),
                                label: const Text('Sign up'))
                          ],
                        ),
                ),
              ),
              Row(
                children: [
                  const Text('You don\'t have an account '),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          haveAcount = !haveAcount;
                          emailcontroller.clear();
                          passwordcontroller.clear();
                          namecontroller.clear();
                          _formkey.currentState!.reset();
                        });
                      },
                      child: const Text('Sign Up')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget emailWidget(Size size) {
    return SizedBox(
      width: size.width * 0.8,
      child: TextFormField(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: emailcontroller, keyboardType: TextInputType.emailAddress,
        validator: (val) {
          String pattern =
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?)*$";
          RegExp regex = RegExp(pattern);
          if (val!.isEmpty || !regex.hasMatch(val)) {
            return 'Enter a valid email address';
          } else {
            return null;
          }
        },
        decoration: const InputDecoration(label: Text('Email')),
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
      ),
    );
  }

  Widget passwordWidget(Size size) {
    return SizedBox(
      width: size.width * 0.8,
      child: TextFormField(
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: passwordcontroller,
        decoration: const InputDecoration(label: Text('password')),
        validator: (val) {
          if (val!.isEmpty) {
            return 'Enter a valid password';
          } else {
            return null;
          }
        },
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
      ),
    );
  }

  Widget nameWidget(Size size) {
    return SizedBox(
      width: size.width * 0.8,
      child: TextFormField(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: namecontroller,
        decoration: const InputDecoration(label: Text('name')),
        validator: (val) {
          if (val!.isEmpty) {
            return 'Enter a valid name';
          } else {
            return null;
          }
        },
        onChanged: (value) {
          setState(() {
            name = value;
          });
        },
      ),
    );
  }
}
