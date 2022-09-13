import 'package:aos/data/datasources/rule_source_remote_datasource.dart';
import 'package:aos/data/repositories/repository.dart';

class GenerateResetToStart {
  generateResetToStart() {
    RuleRepoImp repo = RuleRepoImp();
    repo.fireStoreDeleteUserCollection(RuleSourceRemoteDatasourceImp());
  }
}
