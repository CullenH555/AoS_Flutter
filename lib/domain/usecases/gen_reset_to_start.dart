import '../../data/repositories/repository.dart';
import '../entities/rule_source.dart';

class GenResetToStart {
  call({
    required String user,
  }) async {
    try {
      RuleRepoImp repository = RuleRepoImp();
      repository.fireStoreDeleteUserCollection(user);
    } catch (e) {
      return "Error";
    }
  }
}
