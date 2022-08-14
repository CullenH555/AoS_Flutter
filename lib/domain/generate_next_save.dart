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
  generateNextSave(currentSource) async {
    try {
      final _firestore = FirebaseFirestore.instance;
      await _firestore.collection('saveTest1').add({
        'sourceName': currentSource.sourceName,
      });
      return 'Saved!';
    } catch (e) {
      print(e);
    }
  }

  generateNextDelete(currentSource) async {
    try {
      final _firestore = FirebaseFirestore.instance;
      await _firestore
          .collection('saveTest1')
          .doc(currentSource.sourceName)
          .delete();
      return 'Saved!';
    } catch (e) {
      print(e);
    }
  }
}
