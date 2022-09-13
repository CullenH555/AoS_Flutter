import 'package:aos/data/repositories/repository.dart';

import '../entities/rule_source.dart';

// GenNextPage combines the user's data with all available data in order
// to generate the list of RuleSource for the next page.
class GenNextPage {
  // For use in implementing GetIt Dependency Injection.
  /* final RuleRepository repository;
  GenNextPage({required this.repository});*/
  Future<List<RuleSource>> call({
    required List<RuleSource> currentSources,
    required String direction,
    required String user,
  }) async {
    print('we are inside gen next page');
    List<RuleSource> nextSources = [];
    // Invoke repo to get all Source data and all user's Source data
    RuleRepoImp repository = RuleRepoImp();
    List<RuleSource> data = await repository.getOrganizedDataFromRepo();
    List<RuleSource> ruleSources = await repository.getRuleSourcesFromDb(user);
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
