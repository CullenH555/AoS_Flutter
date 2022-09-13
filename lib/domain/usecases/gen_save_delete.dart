import '../../data/repositories/repository.dart';
import '../entities/rule_source.dart';

class GenNextSave {
  Future<List<RuleSource>> call({
    required List<RuleSource> currentSources,
    required RuleSource currentSource,
    required String user,
  }) async {
    for (var j = 0; j < currentSources.length; j++) {
      if (currentSources[j] == currentSource) {
        if (currentSources[j].sourceActive == true) {
          try {
            RuleRepoImp repository = RuleRepoImp();
            repository.fireStoreRuleSourceUpdate(
                user, currentSource, currentSources);
            return currentSources;
          } catch (e) {
            print(e);
          }
        } else {
          String currentSourceId;
          try {
            RuleRepoImp repository = RuleRepoImp();
            currentSourceId = currentSources[j].sourceId;
            repository.fireStoreRuleSourceDelete(user, currentSourceId);
            return currentSources;
          } catch (e) {
            print(e);
          }
        }
      }
    }
    return [];
  }
}
