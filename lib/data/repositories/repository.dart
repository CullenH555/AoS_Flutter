// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:aos/data/datasources/rule_source_remote_datasource.dart';
import '../../domain/entities/rule.dart';
import '../../domain/entities/rule_source.dart';

// The RuleRepository contains the contract and implementation
// for the application's organized rule data from datasources for eventual
// use by the UI.
// Its methods return entities to the usecases.
// See rule_source_remote_datasource as the Datasource for details on methods.
abstract class RuleRepository {
  Future<List<RuleSource>> getOrganizedDataFromDb();
  Future<List<RuleSource>> getRuleSourcesFromDb(user);
  Future<List<Rule>> getRulesFromDb();
  void fireStoreRuleSourceDelete(user, currentSourceId);
  void fireStoreRuleSourceUpdate(user, currentSource, currentSources);
  fireStoreDeleteUserCollection(user);
}

class RuleRepoImp implements RuleRepository {
  // For use in implementing GetIt Dependency Injection.
  final RuleSourceRemoteDatasource remoteDatasource;
  RuleRepoImp({required this.remoteDatasource});
  // For use in non GetIt implementation
  /*final RuleSourceRemoteDatasourceImp remoteDatasource =
      RuleSourceRemoteDatasourceImp();
  RuleRepoImp();*/
  @override
  Future<List<RuleSource>> getOrganizedDataFromDb() async {
    final remoteData = await remoteDatasource.getOrganizedDataFromDb();
    return remoteData;
  }

  @override
  Future<List<RuleSource>> getRuleSourcesFromDb(user) async {
    final remoteRuleSources = await remoteDatasource.getRuleSourcesFromDb(user);
    return remoteRuleSources;
  }

  @override
  Future<List<Rule>> getRulesFromDb() async {
    final remoteRules = await remoteDatasource.getRulesFromDb();
    return remoteRules;
  }

  @override
  void fireStoreRuleSourceDelete(user, currentSourceId) async {
    remoteDatasource.fireStoreRuleSourceDelete(user, currentSourceId);
  }

  // Should user be passed in to method?
  @override
  void fireStoreRuleSourceUpdate(user, currentSource, currentSources) {
    remoteDatasource.fireStoreRuleSourceUpdate(
        user, currentSource, currentSources);
  }

  @override
  fireStoreDeleteUserCollection(user) async {
    final remoteRules =
        await remoteDatasource.fireStoreDeleteUserCollection(user);
    return remoteRules;
  }
}
