import 'package:aos/data/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/rule.dart';
import 'package:aos/domain/entities/ruleSource.dart';

// The Rule Repo organizes rule data from data sources for eventual use by the UI

abstract class RuleRepository {
  Future<List<RuleSource>> getOrganizedDataFromRepo();
  Future<List<RuleSource>> getRuleSourcesFromDb();
  Future<List<Rule>> getRulesFromDb();
}

class RuleRepoImp implements RuleRepository {
  @override
  Future<List<RuleSource>> getOrganizedDataFromRepo() async {
    List<RuleSource> newSourceList = [];
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
      RuleSource newSource = RuleSource(
        sourceName: sourceName,
        sourceFaction: sourceFaction,
        sourceType: sourceType,
        nextSourceType: nextSourceType,
      );
      newSourceList.add(newSource);
    }
    return newSourceList;
  }

  @override
  Future<List<RuleSource>> getRuleSourcesFromDb() async {
    List<RuleSource> ruleSources = [];
    // Should user be generated here from separate repo?
    UserRepoImp getUser = UserRepoImp();
    String user = await getUser.getCurrentUser();
    List<dynamic> sourceItems = <dynamic>[];
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
      RuleSource newSource = RuleSource(
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

  Future<List<Rule>> getRulesFromDb() async {
    List allRulesList = [];
    List<Rule> rulesList = [];
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
      Rule newRule = Rule(ruleName, ruleText, rulePhase, ruleSource);
      rulesList.add(newRule);
    }
    return rulesList;
  }

  void fireStoreRuleSourceDelete(user, currentSourceId) async {
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection(user).doc(currentSourceId).delete();
  }

  // Should user be passed in to method?
  Future<List<RuleSource>> fireStoreRuleSourceUpdate(
      user, currentSource, currentSources) {
    final _firestore = FirebaseFirestore.instance;
    return _firestore.collection(user).add({
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
      return currentSources;
    });
  }
}

// Pretend this came from a db.
var MockDbData = [
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
