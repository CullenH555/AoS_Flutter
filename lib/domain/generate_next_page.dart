import 'package:aos/domain/get_sources_from_db.dart';
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
  generateNextPage(currentSources) async {
    List<Source> nextSources = [];
    Repo repo = RepoImp();
    var data = await repo.getOrganizedDataFromRepo();
    print('After calling repo inside gen next page the data is: ');
    print(data);
    var getSourceItems = GetSourcesFromDb();
    var sourceItems = await getSourceItems.getSourcesFromDb();
    print(sourceItems[0]['sourceName']);
    print(currentSources);
    var currentFaction = '';
    // Go through the saved db entries and extract the faction selected.
    for (var j = 0; j < sourceItems.length; j++) {
      if (sourceItems[j]['sourceType'] == 'faction') {
        currentFaction = sourceItems[j]['sourceFaction'];
        print('currentFaction is: ');
        print(currentFaction);
      }
    }
    // Using the nextSourceType and the faction, generate nextSources list.
    for (var i = 0; i < data.length; i++) {
      if (data[i].sourceType == currentSources[0].nextSourceType &&
          data[i].sourceFaction == currentFaction) {
        print('matched: ');
        print(data[i].sourceType);
        print('with: ');
        print(currentSources[0].nextSourceType);
        print(data[i]);
        nextSources.add(data[i]);
      }
    }
    print('nextSources after generateNextPage returns...');
    print(nextSources);
    return nextSources;
  }
}
