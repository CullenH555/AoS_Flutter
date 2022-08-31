import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

class GenerateUserActions extends Equatable {
  GenerateUserActions({this.email = '', this.password = ''});

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

  generateUserCollection(email) async {
    try {
      print('We got inside generateUserCollection');
      final _firestore = FirebaseFirestore.instance;
      _firestore.collection(email).add({
        'sourceName': 'name',
        'sourceFaction': 'faction',
        'sourceType': 'type',
        'nextSourceType': 'nextType',
        'sourceActive': 'active',
        'sourceId': 'id',
      });
    } catch (e) {
      return 'Error';
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

  getCurrentUser() async {
    String loggedInUser;
    try {
      final _auth = FirebaseAuth.instance;
      final user = await _auth.currentUser!;
      loggedInUser = user.email.toString();
      print(loggedInUser.runtimeType);
      return loggedInUser;
    } catch (e) {
      print(e);
    }
  }
}
