import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frsc_presentation/screens/dashboard/user_dashboard.dart';
import 'package:frsc_presentation/screens/home/homescreen_view.dart';
import 'package:frsc_presentation/screens/login/login_view.dart';
import 'package:frsc_presentation/utilities/navigation.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<String?> login(
      BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      pushPage(context, const UserDashboard());
      return "Logged In";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Incorrect Email Address!")));
          break;
        case "ERROR_WRONG_PASSWORD":
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Incorrect Password!")));
          break;
        case "ERROR_USER_NOT_FOUND":
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("User not found!")));
          break;
        case "ERROR_USER_DISABLED":
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("User with this email has been disabled!")));
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Too many requests, try again later!")));
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Check if your credentials are correct!")));
      }
    }
  }

  Future<String?> logOut() async {
    await _auth.signOut();
  }

  Future<String?> signUp(
      BuildContext context, String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User user = FirebaseAuth.instance.currentUser!;

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'password': password,
        });
        _auth.currentUser!.sendEmailVerification();
        pushPage(context, const LoginView());
      });
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }
}
