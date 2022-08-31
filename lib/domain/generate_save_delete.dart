import 'dart:ffi';

import 'package:aos/domain/generate_user_actions.dart';
import 'package:aos/old_files/generate_current_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'entities/ruleSource.dart';
import '../data/repository.dart';
import '../old_files/next_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GenerateNextSave extends Equatable {
  @override
  List<Object?> get props => [];

  generateNextSave(currentSource, currentSources) async {
    var getUser = GenerateUserActions();
    var user = await getUser.getCurrentUser();
    for (var j = 0; j < currentSources.length; j++) {
      if (currentSources[j] == currentSource) {
        if (currentSources[j].sourceActive == true) {
          try {
            final _firestore = FirebaseFirestore.instance;
            return _firestore.collection(user).add({
              'sourceName': currentSource.sourceName,
              'sourceFaction': currentSource.sourceFaction,
              'sourceType': currentSource.sourceType,
              'nextSourceType': currentSource.nextSourceType,
              'sourceActive': currentSource.sourceActive,
              'sourceId': currentSource.sourceId,
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
              _firestore
                  .collection(user)
                  .doc(recordId)
                  .update({'sourceId': recordId});
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
                await _firestore.collection(user).doc(currentSourceId).delete();
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
    var getUser = GenerateUserActions();
    var user = await getUser.getCurrentUser();
    var currentSourceId;
    try {
      print("currentSourceId before trying to delete: ");
      for (var j = 0; j < currentSources.length; j++) {
        if (currentSources[j] == currentSource) {
          currentSourceId = currentSources[j].sourceId;
          print(currentSources[j]);
          print(currentSourceId);
          final _firestore = FirebaseFirestore.instance;
          await _firestore.collection(user).doc(currentSourceId).delete();
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
