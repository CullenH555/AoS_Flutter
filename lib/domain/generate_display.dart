import 'dart:ffi';

import 'package:equatable/equatable.dart';

import 'entities/source.dart';

class GenerateDisplay extends Equatable {
  @override
  List<Object?> get props => [];

  //  Generating the next page takes in the current list of sources and generates the next.
  generateDisplay(currentSources) {
    for (var i = 0; i < currentSources.length; i++) {
      print(currentSources[i].rulesList);
    }
  }
}
