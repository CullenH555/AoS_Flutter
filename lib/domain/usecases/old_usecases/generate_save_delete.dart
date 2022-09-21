import 'package:aos/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repositories/repository.dart';
import '../../entities/rule_source.dart';

class GenerateNextSave extends Equatable {
  @override
  List<Object?> get props => [];

  generateNextSave(currentSource, currentSources) async {
    UserRepoImp getUser = UserRepoImp();
    String user = await getUser.getCurrentUser();
    for (var j = 0; j < currentSources.length; j++) {
      if (currentSources[j] == currentSource) {
        if (currentSources[j].sourceActive == true) {
          try {
            RuleRepoImp repo = RuleRepoImp();
            void repoUpdate = repo.fireStoreRuleSourceUpdate(
                user, currentSource, currentSources);
            return repoUpdate;
          } catch (e) {
            print(e);
          }
        } else {
          String currentSourceId;
          try {
            for (var j = 0; j < currentSources.length; j++) {
              if (currentSources[j] == currentSource) {
                currentSourceId = currentSources[j].sourceId;
                RuleRepoImp repo = RuleRepoImp();
                repo.fireStoreRuleSourceDelete(user, currentSourceId);
                return currentSources;
              }
            }
          } catch (e) {
            print(e);
          }
        }
      }
    }
  }

// Should the below be its own separated function?
// Or is it inherently part of "save/delete"

/*generateNextDelete(currentSource, currentSources) async {
    var getUser = GenerateUserActions();
    var user = await getUser.getCurrentUser();
    var currentSourceId;
    try {
      print("currentSourceId before trying to delete: ");
      for (var j = 0; j < currentSources.length; j++) {
        if (currentSources[j] == currentSource) {
          currentSourceId = currentSources[j].sourceId;
          print(currentSources[j]);
          print(currentSourceId);
         var repo = RepoImp();
                repo.fireStoreRuleSourceDelete(user, currentSourceId);
          print('inside Delete function, deleted: ');
          print(currentSourceId);
          return currentSources;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
*/

}
