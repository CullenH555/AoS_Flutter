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

  /*
  // This is the "older" version of the save functionality.
  //  Generating the next page takes in the current list of sources and generates the next.
  generateNextSave(currentSource, currentSources) async {
    try {
      final _firestore = FirebaseFirestore.instance;
      return _firestore.collection('saveTest1').add({
        'sourceName': currentSource.sourceName,
      }).then((value) {
        var recordId = value.id;
        print('we to stringed it');
        print(recordId);
        for (var i = 0; i < currentSources.length; i++) {
          if (currentSources[i] == currentSource) {
            currentSources[i].setSourceId(recordId);
          }
          print(currentSources[i]);
        }
        return currentSources;
      });
    } catch (e) {
      print(e);
    }
  }
  */

  generateNextSave(currentSource, currentSources) async {
    for (var j = 0; j < currentSources.length; j++) {
      if (currentSources[j] == currentSource) {
        if (currentSources[j].sourceActive == true) {
          try {
            final _firestore = FirebaseFirestore.instance;
            return _firestore.collection('saveTest1').add({
              'sourceName': currentSource.sourceName,
            }).then((value) {
              var recordId = value.id;
              print('we to stringed it');
              print(recordId);
              for (var i = 0; i < currentSources.length; i++) {
                if (currentSources[i] == currentSource) {
                  currentSources[i].setSourceId(recordId);
                }
                print(currentSources[i]);
              }
              return currentSources;
            });
          } catch (e) {
            print(e);
          }
        } else {
          var currentSourceId;
          try {
            print("currentSourceId before trying to delete: ");
            for (var j = 0; j < currentSources.length; j++) {
              if (currentSources[j] == currentSource) {
                currentSourceId = currentSources[j].sourceId;
                print(currentSources[j]);
                print(currentSourceId);
                final _firestore = FirebaseFirestore.instance;
                await _firestore
                    .collection('saveTest1')
                    .doc(currentSourceId)
                    .delete();
                print('inside Delete function, deleted: ');
                print(currentSourceId);
                return currentSources;
              }
            }
          } catch (e) {
            print(e);
          }
        }
      }
    }
  }

  generateNextDelete(currentSource, currentSources) async {
    var currentSourceId;
    try {
      print("currentSourceId before trying to delete: ");
      for (var j = 0; j < currentSources.length; j++) {
        if (currentSources[j] == currentSource) {
          currentSourceId = currentSources[j].sourceId;
          print(currentSources[j]);
          print(currentSourceId);
          final _firestore = FirebaseFirestore.instance;
          await _firestore
              .collection('saveTest1')
              .doc(currentSourceId)
              .delete();
          print('inside Delete function, deleted: ');
          print(currentSourceId);
          return currentSources;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
