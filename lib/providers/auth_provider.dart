import 'dart:developer';

import 'package:chatty/data/auth_repo.dart';
import 'package:chatty/models/user_model.dart';
import 'package:chatty/utils/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier with ChangeNotifier {
  final AuthRepo _authRepo = AuthRepo();

  late UserModel currentUser;
  void checkCurrentUser(BuildContext context) async {
    try {
      currentUser = await _authRepo.checkCurrentUser();
      if (currentUser != null) {
        Navigator.of(context).pushReplacementNamed(RouteNames.homeScreen);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
      }
    } on FirebaseException catch (error, stk) {
      log("Error code: ${error.code}, Message: ${error.message}");
      Navigator.of(context).pushReplacementNamed(RouteNames.loginScreen);
    }
  }

  void login(BuildContext context,
      {required String email, required String password}) async {
    try {
      currentUser = await _authRepo.login(email: email, password: password);
      if (currentUser != null) {
        Navigator.of(context).pushReplacementNamed(RouteNames.homeScreen);
      }
    } on FirebaseAuthException catch (error, stk) {
      print("ERROR OCCURED IN NETWORK FUNCTION: DISPLAYING IN PROVIDER");
    }
  }

  void register(BuildContext context,
      {required String name,
      required String email,
      required String password}) async {
    final UserModel user = UserModel(email: email, name: name, uid: "");

    try {
      currentUser = await _authRepo.register(user: user, password: password);

      Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
    } on FirebaseException catch (error, stk) {
      //TODO: Handle Exception
    }
  }

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();

    Navigator.of(context)
        .pushNamedAndRemoveUntil(RouteNames.loginScreen, (route) => false);
  }
}
