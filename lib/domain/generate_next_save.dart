import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'entities/source.dart';
import '../data/repository.dart';
import '../presentation/pages/next_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GenerateNextSave extends Equatable {
  @override
  List<Object?> get props => [];

  //  Generating the next page takes in the current list of sources and generates the next.
  generateNextSave(currentSource, currentSourceId) async {
    try {
      final _firestore = FirebaseFirestore.instance;
      return _firestore.collection('saveTest1').add({
        'sourceName': currentSource.sourceName,
      }).then((value) {
        var recordId = value.id;
        print('we to stringed it');
        print(recordId);
        return recordId;
      });
    } catch (e) {
      print(e);
    }
  }

  generateNextDelete(currentSource, currentSourceId) async {
    try {
      print("currentSourceId before trying to delete: ");
      print(currentSourceId);
      final _firestore = FirebaseFirestore.instance;
      await _firestore.collection('saveTest1').doc(currentSourceId).delete();
      print('inside Delete function, deleted: ');
      print(currentSourceId);
      print(_firestore.collection('saveTest1').doc(currentSource.sourceName));
      return 'Saved!';
    } catch (e) {
      print(e);
    }
  }
}
