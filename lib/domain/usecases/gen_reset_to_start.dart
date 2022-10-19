import 'package:aos_playmat_builder_flutter/data/repositories/repository.dart';

// GenResetToStart takes the current user and deletes the user's save
// collection in order to reset it.
class GenResetToStart {
  // For use in implementing GetIt Dependency Injection.
  final RuleRepository repository;
  GenResetToStart({required this.repository});
  call({
    required String user,
  }) async {
    try {
      // For use in non GetIt implementation
      // RuleRepoImp repository = RuleRepoImp();
      repository.fireStoreDeleteUserCollection(user);
    } catch (e) {
      return "Error";
    }
  }
}
