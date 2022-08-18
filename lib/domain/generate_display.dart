import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'entities/source.dart';

class GenerateDisplay extends Equatable {
  @override
  List<Object?> get props => [];

  //  Generating the next page takes in the current list of sources and generates the next.
  generateDisplay() async {
    var items = <dynamic>[];
    final _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('saveTest1')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach(
        // add data to your list
        (f) => items.add(f.data()),
      );
    });
    print(items);
    return items;
  }
}
