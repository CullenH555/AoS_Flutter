import 'package:aos/domain/get_sources_from_db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'entities/ruleSource.dart';
import '../data/repository.dart';

class GeneratePreviousPage extends Equatable {
  GeneratePreviousPage({this.currentSources = const <RuleSource>[]});
  List<RuleSource> currentSources;

  @override
  List<Object?> get props => [currentSources];

  //  Generating the next page takes in the current list of sources and generates the next.
  generatePreviousPage(currentSources) async {
    // print(currentSources);
    List<RuleSource> previousSources = [];
    Repo repo = RepoImp();
    var data = await repo.getOrganizedDataFromRepo();
    var getSourceItems = GetSourcesFromDb();
    var sourceItems = await getSourceItems.getSourcesFromDb();
    //   print(sourceItems[0]['sourceName']);
    //   print(currentSources);
    var currentFaction = '';
    // Go through the saved db entries and extract the faction selected.
    for (var j = 0; j < sourceItems.length; j++) {
      if (sourceItems[j]['sourceType'] == 'faction') {
        currentFaction = sourceItems[j]['sourceFaction'];
        //    print('currentFaction is: ');
        //    print(currentFaction);
      }
    }
    var repoImp = RepoImp();
    var ruleSources = await repoImp.getRuleSourcesFromDb();
    // Using the sourceType and the faction, generate previousSources list.
    for (var source in ruleSources) {
      if (source.nextSourceType == currentSources[0].sourceType &&
          source.sourceFaction == currentFaction) {
        previousSources.add(source);
      }
    }
    for (var rule in data) {
      if (rule.nextSourceType == currentSources[0].sourceType &&
          rule.sourceFaction == currentFaction) {
        previousSources.add(rule);
      }
    }
    // Make sure only one instance of each Source is added.
    var seen = Set<String>();
    previousSources =
        previousSources.where((source) => seen.add(source.sourceName)).toList();
    //  print('previousSources after generatePreviousPage returns...');
    print(previousSources);
    return previousSources;
  }
}
