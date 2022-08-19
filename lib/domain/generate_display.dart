import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'entities/source.dart';

class GenerateDisplay extends Equatable {
  @override
  List<Object?> get props => [];

  //  Generating the display retrieves the data from the db and returns a list of rules.
  generateDisplay() async {
    var items = <dynamic>[];
    final _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('saveTest1')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach(
        // add data to the list
        (f) => items.add(f.data()),
      );
    });
    // At this point items should be:
    // [{sourceName: 'WoodAelves'}, {sourceName: 'Sylvaneth'}]
    print(items);
    return items;
  }
}
