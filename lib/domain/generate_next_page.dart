import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'entities/source.dart';
import '../data/repository.dart';
import '../presentation/pages/next_page.dart';

class GenerateNextPage extends Equatable {
  GenerateNextPage({this.currentSources = const <Source>[]});
  List<Source> currentSources;

  @override
  List<Object?> get props => [currentSources];

  //  Generating the next page takes in the current list of sources and generates the next.
  generateNextPage(currentSources) {
    List<Source> nextSources = [];
    Repo repo = RepoImp();
    List<Source> data = repo.getOrganizedDataFromRepo();
    for (var i = 0; i < data.length; i++) {
      if (data[i].sourceType == currentSources[0].nextSourceType &&
          data[i].sourceFaction == currentSources[0].sourceFaction) {
        nextSources.add(data[i]);
      }
    }
    return [nextSources];
  }
}
