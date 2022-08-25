import 'package:aos/domain/get_sources_from_db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'entities/ruleSource.dart';
import '../data/repository.dart';
import '../presentation/pages/next_page.dart';

class GenerateNextPage extends Equatable {
  GenerateNextPage({this.currentSources = const <RuleSource>[]});
  List<RuleSource> currentSources;

  @override
  List<Object?> get props => [currentSources];

  //  Generating the next page takes in the current list of sources and generates the next.
  generateNextPage(currentSources) async {
    print('we are inside gen next page');
    print(currentSources);
    List<RuleSource> nextSources = [];
    Repo repo = RepoImp();
    var data = await repo.getOrganizedDataFromRepo();
    //  print('After calling repo inside gen next page the data is: ');
    //  print(data);
    var getSourceItems = GetSourcesFromDb();
    var sourceItems = await getSourceItems.getSourcesFromDb();
    print(sourceItems[0]['sourceName']);
    print(currentSources);
    var currentFaction = '';
    // Go through the saved db entries and extract the faction selected.
    for (var j = 0; j < sourceItems.length; j++) {
      if (sourceItems[j]['sourceType'] == 'faction') {
        currentFaction = sourceItems[j]['sourceFaction'];
        //     print('currentFaction is: ');
        //     print(currentFaction);
      }
    }
    // Using the nextSourceType and the faction, generate nextSources list.
    for (var i = 0; i < data.length; i++) {
      if (data[i].sourceType == currentSources[0].nextSourceType &&
          data[i].sourceFaction == currentFaction) {
        nextSources.add(data[i]);
      }
    }
    var seen = Set<String>();
    nextSources =
        nextSources.where((source) => seen.add(source.sourceName)).toList();
    //   print('nextSources after generateNextPage returns...');
    //   print(nextSources);
    return nextSources;
  }
}
