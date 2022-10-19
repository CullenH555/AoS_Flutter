// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// The UserRepository organizes user data for credentials, saving etc.
// Perhaps refactor methods into user usecases?

abstract class UserRepository {
  final String email;
  final String password;
  generateRegisteredUser(email, password);
  generateUserCollection(email);
  generateLoggedInUser(email, password);
  generateLoggedOutUser();
  Future<String> getCurrentUser();
  UserRepository(this.email, this.password);
}

class UserRepoImp implements UserRepository {
  @override
  UserRepoImp({this.email = '', this.password = ''});

  @override
  final String email;
  @override
  final String password;

  @override
  List<Object?> get props => [email, password];

  // Should there be a separate 'user' repo?
  // Or should this be part of the overall repo?
  @override
  generateRegisteredUser(email, password) async {
    final auth = FirebaseAuth.instance;
    try {
      final newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return newUser;
    } catch (e) {
      print(e);
    }
  }

  @override
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

  @override
  generateLoggedInUser(email, password) async {
    final auth = FirebaseAuth.instance;
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      print(e);
    }
  }

  @override
  generateLoggedOutUser() async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> getCurrentUser() async {
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
    return 'Error';
  }
}
