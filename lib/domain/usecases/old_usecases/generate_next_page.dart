import 'package:aos/data/datasources/rule_source_remote_datasource.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repositories/repository.dart';
import '../../entities/rule_source.dart';

class GenerateNextPage extends Equatable {
  GenerateNextPage(
      {this.currentSources = const <RuleSource>[], required this.direction});
  List<RuleSource> currentSources;
  String direction;

  @override
  List<Object?> get props => [currentSources, direction];

  //  Generating the next page takes in the current list of sources and generates the next.
  Future<List<RuleSource>> generateNextPage(currentSources, direction) async {
    print('we are inside gen next page');
    List<RuleSource> nextSources = [];
    RuleRepository repo = RuleRepoImp();
    List<RuleSource> data = await repo.getOrganizedDataFromDb();
    List<RuleSource> ruleSources =
        await repo.getRuleSourcesFromDb(RuleSourceRemoteDatasourceImp());
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
        if (!nextSources.contains(source)) {
          if (source.sourceType == currentSources[0].nextSourceType &&
              source.sourceFaction == currentFaction) {
            nextSources.add(source);
          }
        }
      }
      for (var j = 0; j < data.length; j++) {
        if (!nextSources.contains(data[j])) {
          if (data[j].sourceType == currentSources[0].nextSourceType &&
              data[j].sourceFaction == currentFaction) {
            nextSources.add(data[j]);
          }
        }
      }
    } else if (direction == 'previous') {
      for (var source in ruleSources) {
        if (!nextSources.contains(source)) {
          if (source.nextSourceType == currentSources[0].sourceType &&
              source.sourceFaction == currentFaction) {
            nextSources.add(source);
          }
        }
      }
      for (var rule in data) {
        if (!nextSources.contains(rule)) {
          if (rule.nextSourceType == currentSources[0].sourceType &&
              rule.sourceFaction == currentFaction) {
            nextSources.add(rule);
          }
        }
      }
    }
    print(nextSources);
    return nextSources;
  }
}
