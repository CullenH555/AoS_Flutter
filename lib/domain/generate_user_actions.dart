import 'package:aos/data/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';

class GenerateUserActions extends Equatable {
  @override
  List<Object?> get props => [];

  // Should there be a separate 'user' repo?
  // Or should this be part of the overall repo?

  generateRegisteredUser(email, password) async {
    UserRepoImp repo = UserRepoImp();
    repo.generateRegisteredUser(email, password);
  }

  generateUserCollection(email) async {
    UserRepoImp repo = UserRepoImp();
    repo.generateUserCollection(email);
  }

  generateLoggedInUser(email, password) async {
    UserRepoImp repo = UserRepoImp();
    repo.generateLoggedInUser(email, password);
  }

  generateLoggedOutUser() async {
    UserRepoImp repo = UserRepoImp();
    repo.generateLoggedOutUser();
  }

  getCurrentUser() async {
    UserRepoImp repo = UserRepoImp();
    repo.getCurrentUser();
  }
}
