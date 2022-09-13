// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:aos/data/datasources/rule_source_remote_datasource.dart';
import '../../domain/entities/rule.dart';
import '../../domain/entities/rule_source.dart';

// The Rule Repo organizes rule data from data sources for eventual use by the UI

abstract class RuleRepository {
  Future<List<RuleSource>> getOrganizedDataFromRepo();
  Future<List<RuleSource>> getRuleSourcesFromDb(user);
  Future<List<Rule>> getRulesFromDb();
  void fireStoreRuleSourceDelete(user, currentSourceId);
  void fireStoreRuleSourceUpdate(user, currentSource, currentSources);
  fireStoreDeleteUserCollection(user);
}

class RuleRepoImp implements RuleRepository {
  final RuleSourceRemoteDatasourceImp remoteDatasource =
      RuleSourceRemoteDatasourceImp();
  RuleRepoImp();
  @override
  Future<List<RuleSource>> getOrganizedDataFromRepo() async {
    final remoteData = await remoteDatasource.getOrganizedDataFromRepo();
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
