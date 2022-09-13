import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/rule.dart';
import '../../domain/entities/rule_source.dart';
import '../models/rule_model.dart';
import '../models/rule_source_model.dart';
import '../repositories/user_repository.dart';

abstract class RuleSourceRemoteDatasource {
  Future<List<RuleSourceModel>> getOrganizedDataFromRepo();
  Future<List<RuleSourceModel>> getRuleSourcesFromDb(user);
  Future<List<RuleModel>> getRulesFromDb();
  void fireStoreRuleSourceDelete(user, currentSourceId);
  void fireStoreRuleSourceUpdate(user, currentSource, currentSources);
  fireStoreDeleteUserCollection(user);
}

class RuleSourceRemoteDatasourceImp implements RuleSourceRemoteDatasource {
  @override
  fireStoreDeleteUserCollection(user) async {
    final _firestore = FirebaseFirestore.instance;
    var snapshots = await _firestore.collection(user).get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  @override
  void fireStoreRuleSourceDelete(user, currentSourceId) async {
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection(user).doc(currentSourceId).delete();
  }

  @override
  void fireStoreRuleSourceUpdate(user, currentSource, currentSources) async {
    final _firestore = FirebaseFirestore.instance;
    return await _firestore.collection(user).add({
      'sourceName': currentSource.sourceName,
      'sourceFaction': currentSource.sourceFaction,
      'sourceType': currentSource.sourceType,
      'nextSourceType': currentSource.nextSourceType,
      'sourceActive': currentSource.sourceActive,
      'sourceId': currentSource.sourceId,
    }).then((value) {
      String recordId = value.id;
      for (var i = 0; i < currentSources.length; i++) {
        if (currentSources[i] == currentSource) {
          currentSources[i].setSourceId(recordId);
        }
      }
      _firestore.collection(user).doc(recordId).update({'sourceId': recordId});
    });
  }

  @override
  Future<List<RuleSourceModel>> getOrganizedDataFromRepo() async {
    List<RuleSourceModel> newSourceList = [];
    List allRulesList = [];
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection('rules').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((e) {
        allRulesList.add(e.data());
      });
    });
    String sourceType = '';
    String nextSourceType = '';
    for (var i = 0; i < allRulesList.length; i++) {
      if (allRulesList[i]['ruleSourceType'].toString() == 'Unit ability') {
        sourceType = 'warscroll';
        nextSourceType = 'battalion';
      } else if (allRulesList[i]['ruleSourceType'].toString() == 'Artifact') {
        sourceType = 'artifact';
        nextSourceType = 'warscroll';
      } else if (allRulesList[i]['ruleSourceType'].toString() ==
              'Subfaction Ability' ||
          allRulesList[i]['ruleSourceType'].toString() ==
              'Subfaction ability') {
        sourceType = 'subfaction';
        nextSourceType = 'command';
      } else if (allRulesList[i]['ruleSourceType'].toString() ==
          'Allegiance ability') {
        sourceType = 'faction';
        nextSourceType = 'subfaction';
      } else if (allRulesList[i]['ruleSourceType'].toString() ==
          'Battalion ability') {
        sourceType = 'battalion';
        nextSourceType = 'end';
      } else if (allRulesList[i]['ruleSourceType'].toString() ==
          'Command Trait') {
        sourceType = 'command';
        nextSourceType = 'artifact';
      } else {
        sourceType = 'other';
        nextSourceType = 'other';
      }
      String sourceName = allRulesList[i]['ruleSource'].toString();
      String sourceFaction = allRulesList[i]['ruleFaction'].toString();
      RuleSourceModel newSource = RuleSourceModel(
        sourceName: sourceName,
        sourceFaction: sourceFaction,
        sourceType: sourceType,
        nextSourceType: nextSourceType,
        sourceActive: false,
        sourceId: '',
      );
      newSourceList.add(newSource);
    }
    return newSourceList;
  }

  @override
  Future<List<RuleSourceModel>> getRuleSourcesFromDb(user) async {
    List<dynamic> sourceItems = <dynamic>[];
    List<RuleSourceModel> ruleSources = [];
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection(user).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach(
        // add data to the list
        (f) => sourceItems.add(f.data()),
      );
    });
    bool sourceActive;
    for (var i = 0; i < sourceItems.length; i++) {
      String sourceId = sourceItems[i]['sourceId'];
      String sourceType = sourceItems[i]['sourceType'];
      String sourceName = sourceItems[i]['sourceName'];
      if (sourceItems[i]['sourceActive'] == true) {
        sourceActive = true;
      } else {
        sourceActive = false;
      }
      String nextSourceType = sourceItems[i]['nextSourceType'];
      String sourceFaction = sourceItems[i]['sourceFaction'];
      RuleSourceModel newSource = RuleSourceModel(
        sourceName: sourceName,
        sourceFaction: sourceFaction,
        sourceType: sourceType,
        nextSourceType: nextSourceType,
        sourceId: sourceId,
        sourceActive: sourceActive,
      );
      ruleSources.add(newSource);
    }
    return ruleSources;
  }

  @override
  Future<List<RuleModel>> getRulesFromDb() async {
    List allRulesList = [];
    List<RuleModel> rulesList = [];
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection('rules').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((e) {
        allRulesList.add(e.data());
      });
    });
    for (var rule in allRulesList) {
      String ruleName = rule['ruleName'];
      String ruleText = rule['ruleText'];
      String rulePhase = rule['rulePhase'];
      String ruleSource = rule['ruleSource'];
      String ruleSourceType = rule['ruleSourceType'];
      String ruleFaction = rule['ruleFaction'];
      RuleModel newRule = RuleModel(
          ruleName: ruleName,
          ruleText: ruleText,
          rulePhase: rulePhase,
          ruleSource: ruleSource,
          ruleSourceType: ruleSourceType,
          ruleFaction: ruleFaction);
      rulesList.add(newRule);
    }
    return rulesList;
  }
}

// Pretend this came from a db.
var mockDbData = [
  {
    'SourceName': 'Sylvaneth',
    'SourceFaction': 'sylvaneth',
    'SourceType': 'faction',
    'NextSourceType': 'subfaction',
    'SourceRules': []
  },
  {
    'SourceName': 'Winterleaf',
    'SourceFaction': 'sylvaneth',
    'SourceType': 'subfaction',
    'NextSourceType': 'artifact',
    'SourceRules': []
  },
  {
    'SourceName': 'Heartwood',
    'SourceFaction': 'sylvaneth',
    'SourceType': 'subfaction',
    'NextSourceType': 'artifact',
    'SourceRules': []
  },
  {
    'SourceName': 'Acorn of the Ages',
    'SourceFaction': 'sylvaneth',
    'SourceType': 'artifact',
    'NextSourceType': 'warscroll',
    'SourceRules': []
  },
  {
    'SourceName': 'Frozen Kernel',
    'SourceFaction': 'sylvaneth',
    'SourceType': 'artifact',
    'NextSourceType': 'warscroll',
    'SourceRules': []
  },
  {
    'SourceName': 'Hammer of Khar',
    'SourceFaction': 'kharadron',
    'SourceType': 'subfaction',
    'NextSourceType': 'artifact',
    'SourceRules': []
  },
  {
    'SourceName': 'Scrying Glass',
    'SourceFaction': 'kharadron',
    'SourceType': 'subfaction',
    'NextSourceType': 'artifact',
    'SourceRules': []
  }
];
