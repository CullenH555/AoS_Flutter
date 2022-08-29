import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'generate_current_user.dart';

class GetSourcesFromDb extends Equatable {
  GetSourcesFromDb();
  getSourcesFromDb() async {
    var getUser = GenerateCurrentUser();
    var user = await getUser.getCurrentUser();
    var sourceItems = <dynamic>[];
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection(user).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach(
        // add data to the list
        (f) => sourceItems.add(f.data()),
      );
    });
    return sourceItems;
  }

  @override
  List<Object?> get props => [];
}
