import 'package:aos/data/repositories/repository.dart';

class GenerateResetToStart {
  generateResetToStart() {
    RuleRepoImp repo = RuleRepoImp();
    repo.fireStoreDeleteUserCollection();
  }
}
