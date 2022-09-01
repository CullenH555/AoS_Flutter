import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';

// The User Repo organizes user data for credentials, saving etc.

abstract class UserRepository {
  final String email;
  final String password;
  generateRegisteredUser(emal, password);
  generateUserCollection(email);
  generateLoggedInUser(email, password);
  generateLoggedOutUser();
  Future<String> getCurrentUser();
  UserRepository(this.email, this.password);
}

class UserRepoImp implements UserRepository {
  @override
  UserRepoImp({this.email = '', this.password = ''});

  final String email;
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
