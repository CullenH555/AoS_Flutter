import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'entities/source.dart';
import '../data/repository.dart';
import '../presentation/pages/next_page.dart';

class GenerateNextSave extends Equatable {
  GenerateNextSave({this.currentSave = const <Source>[]});
  List<Source> currentSave;

  @override
  List<Object?> get props => [currentSave];

  //  Generating the next page takes in the current list of sources and generates the next.
  generateNextSave(currentSave) {
    Repo repo = RepoImp();
    List<Source> oldSave = repo.getOldSaveFromRepo();
    //  print(oldSave.runtimeType);
    oldSave.add(currentSave);
//    print('oldSave is: ');
    //  print(oldSave);
    /*
    for (var i = 0; i < data.length; i++) {
      if (data[i].sourceType == currentSources[0].nextSourceType &&
          data[i].sourceFaction == currentSources[0].sourceFaction) {
        nextSources.add(data[i]);
      }
    }
    */
    //   print('newSave is: ');
    //  print(newSave);
    return oldSave;
  }
}
