import 'package:advancedproj/res/controller/firebase_auth.dart';
import 'package:advancedproj/res/pages/home.dart';
import 'package:advancedproj/res/pages/signed_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../main.dart';

class AuthMiddleware extends GetMiddleware {
  FirebaseSignInController firebaseSignInController =
      Get.put(FirebaseSignInController());
  @override
  RouteSettings? redirect(String? route) {
    if (sharedPreferences!.getString('user') == null) {
      return RouteSettings(
        name: '/home', /*arguments: home()*/
      );
    } else {
      return const RouteSettings(
        name: '/signedin', /*arguments: SiggnedIn()*/
      );
    }
  }
}
