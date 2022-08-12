import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

class GenerateLoggedInUser extends Equatable {
  GenerateLoggedInUser({this.email = '', this.password = ''});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];

  generateLoggedInUser(email, password) async {
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
}
