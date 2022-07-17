import 'package:advancedproj/res/controller/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SiggnedIn extends StatefulWidget {
  const SiggnedIn({Key? key}) : super(key: key);

  @override
  State<SiggnedIn> createState() => _SiggnedInState();
}

class _SiggnedInState extends State<SiggnedIn> {
  FirebaseSignInController firebaseSignInController =
      Get.put(FirebaseSignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(firebaseSignInController.userModel.displayName),
      ),
    );
  }
}
