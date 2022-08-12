import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

class GenerateRegisteredUser extends Equatable {
  GenerateRegisteredUser({this.email = '', this.password = ''});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];

  generateRegisteredUser(email, password) async {
    final auth = FirebaseAuth.instance;
    try {
      final newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        return newUser;
      }
    } catch (e) {
      print(e);
    }
  }

  generateLoggedInUser(email, password) async {
    final auth = FirebaseAuth.instance;
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        return user;
      }
    } catch (e) {
      print(e);
    }
  }

  generateLoggedOutUser() async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
