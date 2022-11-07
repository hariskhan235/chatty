import 'package:chatty/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> checkCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    try {
      if (firebaseUser != null) {
        print(firebaseUser.uid);
        final documentSnapshot =
            await firestore.collection("users").doc(firebaseUser.uid).get();

        if (documentSnapshot.exists) {
          final data = documentSnapshot.data();
          print("USER DATA FROM FIRESTORE ${data}");
          final appUser = UserModel.fromJson(data!, uid: firebaseUser.uid);
          return appUser;
        }
        throw FirebaseException(
            plugin: "Firestore",
            code: "no-data-found",
            message: "No data was found in database");
      }
      throw FirebaseException(
          plugin: "FirebaseAuth",
          code: 'no-user-logged',
          message: "No user was logged in.");
    } on FirebaseException catch (error, stk) {
      throw error;
    }
  }

  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      final UserCredential userCreds = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final userSnapshot =
          await firestore.collection("users").doc(userCreds.user!.uid).get();

      final data = userSnapshot.data()!;

      return UserModel.fromJson(data, uid: userCreds.user!.uid);
    } on FirebaseAuthException catch (error, stk) {
      print('An error occured during sign in: $error \n Stacktrace: $stk');
      throw FirebaseAuthException(code: error.code, message: error.message);
    }
  }

  Future<UserModel> register(
      {required UserModel user, required String password}) async {
    try {
      final UserCredential creds =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: user.email, password: password);
      user.uid = creds.user!.uid;
      await firestore.collection("users").doc(creds.user!.uid).set(
            user.toJson(),
          );
      return user;
    } on FirebaseException catch (error, stk) {
      throw FirebaseException(plugin: "Firebase", message: "Error: $error");
    }
  }
}
