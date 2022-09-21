import '../../data/repositories/repository.dart';
import '../entities/rule_source.dart';

// GenNextSave saves/deletes the currently selected/deselected button's
// data to the user's save collection.
// It takes the current user, the currently selected/deselected currentSource
// and the currently displayed currentSources.
// It is invoked when a user toggles a selection button.
class GenNextSave {
  // For use in implementing GetIt Dependency Injection.
  final RuleRepository repository;
  GenNextSave({required this.repository});
  Future<List<RuleSource>> call({
    required List<RuleSource> currentSources,
    required RuleSource currentSource,
    required String user,
  }) async {
    for (var j = 0; j < currentSources.length; j++) {
      if (currentSources[j] == currentSource) {
        if (currentSources[j].sourceActive == true) {
          try {
            // For use in non GetIt implementation
            // RuleRepoImp repository = RuleRepoImp();
            repository.fireStoreRuleSourceUpdate(
                user, currentSource, currentSources);
            return currentSources;
          } catch (e) {
            print(e);
          }
        } else {
          String currentSourceId;
          try {
            // For use in non GetIt implementation
            // RuleRepoImp repository = RuleRepoImp();
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
