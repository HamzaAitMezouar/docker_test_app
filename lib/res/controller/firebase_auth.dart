import 'dart:convert';

import 'package:advancedproj/main.dart';
import 'package:advancedproj/res/models/user.dart';
import 'package:advancedproj/res/pages/home.dart';
import 'package:advancedproj/res/pages/signed_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class FirebaseSignInController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  late UserModel userModel;
  late Rx<User?> user;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser!);
    // notifying the user of auth changes
    user.bindStream(auth.userChanges());
    ever(user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => const home());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => SiggnedIn());
    }
  }
// Route page when user null

  ///SignIn
  ///
  ///
  ///
  signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      final uri = Uri.http(
        '10.0.2.2:3000',
        'signin',
      );
      final response = await http.post(uri,
          body: jsonEncode(
              {userModel.email: email, userModel.password: password}));
      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(jsonDecode(response.body));
        sharedPreferences!.setString('user', jsonEncode(user.toJson()));
        return userModel;
      } else {
        throw Exception('Failed to Sign in User, in Mongo Db');
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    }
  }

////////////////////// REGISTER
  ///
  ///
  ///
  signUp(String name, String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .set({'uid': result.user!.uid, 'name': name, 'email': email});

      /// add on mongodb
      ///
      print('eresponse.body0----');
      final uri = Uri.https(
        '10.0.2.2:3000',
        'register',
      );
      print('eresponse.body0');
      final response = await http.post(
        uri,
        body: jsonEncode(
            {'dispalyName': name, 'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('eresponse.body');
      print(response.body);
      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(jsonDecode(response.body));
        sharedPreferences!.setString('user', jsonEncode(user.toJson()));
        return userModel;
      } else {
        throw Exception('Failed to create User, in Mongo Db');
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    }
  }

  Future SignOut() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    }
  }
}
