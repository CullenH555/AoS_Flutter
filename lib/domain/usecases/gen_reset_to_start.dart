import '../../data/repositories/repository.dart';

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
