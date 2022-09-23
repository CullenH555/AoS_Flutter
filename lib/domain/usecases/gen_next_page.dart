import 'package:aos/data/repositories/repository.dart';
import '../entities/rule_source.dart';

// GenNextPage combines the user's data with all available data in order
// to generate the list of RuleSource for the next page's selection buttons.
// It takes in the list of currentSources and returns a list of nextSources.
class GenNextPage {
  // For use in implementing GetIt Dependency Injection.
  final RuleRepository repository;
  GenNextPage({required this.repository});
  Future<List<RuleSource>> call({
    required List<RuleSource> currentSources,
    required String direction,
    required String user,
  }) async {
    //  print('we are inside gen next page');
    List<RuleSource> nextSources = [];
    // Invoke repo to get all Source data and all user's Source data.
    // For use in non GetIt implementation:
    // RuleRepoImp repository = RuleRepoImp();
    // Below, data is a list of all the ruleSource from Db based on all rules.
    List<RuleSource> data = await repository.getOrganizedDataFromDb();
    // Below, ruleSources is a list of all the user's saved ruleSource.
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
      // First, collect all matching previously user saved ruleSource.
      for (var source in ruleSources) {
        if (source.sourceType == currentSources[0].nextSourceType &&
            source.sourceFaction == currentFaction) {
          nextSources.add(source);
          print("nextSources after adding from save: ");
          print(nextSources);
        }
      }
      // Next, collect all matching ruleSource from rules Db.
      // TODO Exclude if already added.
      for (var j = 0; j < data.length; j++) {
        // For each datum create a flag that it should be added.
        var shouldAdd = true;
        // Loop through nextSources and don't add if already there.
        for (var k = 0; k < nextSources.length; k++) {
          if (nextSources[k].sourceName == data[j].sourceName) {
            shouldAdd = false;
          }
        }
        // If we should add it, proceed to further processing by nextSourceType.
        if (shouldAdd == true) {
          if (data[j].sourceType == currentSources[0].nextSourceType &&
              data[j].sourceFaction == currentFaction) {
            nextSources.add(data[j]);
            print("nextSources after adding from rules Db: ");
            print(nextSources);
          }
        }
      }
    } else if (direction == 'previous') {
      print(nextSources);
      // First, collect all matching previously user saved ruleSource.
      for (var source in ruleSources) {
        if (source.nextSourceType == currentSources[0].sourceType &&
            source.sourceFaction == currentFaction) {
          nextSources.add(source);
          print("nextSources after adding from save: ");
          print(nextSources);
        }
      }
      // Next, collect all matching ruleSource from rules Db.
      // TODO Exclude if already added.
      for (var x = 0; x < data.length; x++) {
        // For each datum create a flag that it should be added.
        var shouldAdd = true;
        // Loop through nextSources and don't add if already there.
        for (var y = 0; y < nextSources.length; y++) {
          if (nextSources[y].sourceName == data[x].sourceName) {
            shouldAdd = false;
          }
        }
        // If we should add it, proceed to further processing by nextSourceType.
        if (shouldAdd == true) {
          if (data[x].nextSourceType == currentSources[0].sourceType &&
              data[x].sourceFaction == currentFaction) {
            nextSources.add(data[x]);
            print("nextSources after adding from save: ");
            print(nextSources);
          }
        }
      }
    }
    return nextSources;
  }
}
