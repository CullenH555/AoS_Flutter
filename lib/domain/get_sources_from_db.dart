import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GetSourcesFromDb extends Equatable {
  GetSourcesFromDb();
  getSourcesFromDb() async {
    var sourceItems = <dynamic>[];
    final _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('saveTest1')
        .get()
        .then((QuerySnapshot snapshot) {
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
