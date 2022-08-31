/*
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GenerateCurrentUser extends Equatable {
  GenerateCurrentUser();
  @override
  List<Object?> get props => [];
  final _auth = FirebaseAuth.instance;
  var loggedInUser;
  // Do all of this user setting during initState of the first page.
  getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      loggedInUser = user.email.toString();
      print(loggedInUser.runtimeType);
      return loggedInUser;
    } catch (e) {
      print(e);
    }
  }
}
*/
