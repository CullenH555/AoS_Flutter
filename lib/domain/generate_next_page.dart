import 'package:equatable/equatable.dart';
import 'entities/ruleSource.dart';
import '../data/repository.dart';

class GenerateNextPage extends Equatable {
  GenerateNextPage(
      {this.currentSources = const <RuleSource>[], required this.direction});
  List<RuleSource> currentSources;
  String direction;

  @override
  List<Object?> get props => [currentSources, direction];

  //  Generating the next page takes in the current list of sources and generates the next.
  generateNextPage(currentSources, direction) async {
    print('we are inside gen next page');
    List<RuleSource> nextSources = [];
    Repo repo = RepoImp();
    List<RuleSource> data = await repo.getOrganizedDataFromRepo();
    List<RuleSource> ruleSources = await repo.getRuleSourcesFromDb();
    String currentFaction = '';
    // Go through the saved db entries and extract the faction selected.
    for (var i = 0; i < ruleSources.length; i++) {
      if (ruleSources[i].sourceType == 'faction') {
        currentFaction = ruleSources[i].sourceFaction;
      }
    }
    // Using the nextSourceType and the faction, generate nextSources list.
    if (direction == 'next') {
      for (var source in ruleSources) {
        if (source.sourceType == currentSources[0].nextSourceType &&
            source.sourceFaction == currentFaction) {
          nextSources.add(source);
        }
      }
      for (var j = 0; j < data.length; j++) {
        if (data[j].sourceType == currentSources[0].nextSourceType &&
            data[j].sourceFaction == currentFaction) {
          nextSources.add(data[j]);
        }
      }
    } else if (direction == 'previous') {
      for (var source in ruleSources) {
        if (source.nextSourceType == currentSources[0].sourceType &&
            source.sourceFaction == currentFaction) {
          nextSources.add(source);
        }
      }
      for (var rule in data) {
        if (rule.nextSourceType == currentSources[0].sourceType &&
            rule.sourceFaction == currentFaction) {
          nextSources.add(rule);
        }
      }
    }
    var seen = Set<String>();
    nextSources =
        nextSources.where((source) => seen.add(source.sourceName)).toList();
    return nextSources;
  }
}
