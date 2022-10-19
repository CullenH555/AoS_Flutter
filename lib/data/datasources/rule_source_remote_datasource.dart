// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aos_playmat_builder_flutter/data/models/rule_model.dart';
import 'package:aos_playmat_builder_flutter/data/models/rule_source_model.dart';

// The RuleSourceRemoteDatasource contains the contract and implementation
// for the application's interface to the outside, ie firebase firestore db.
// Its methods return models to the repository, to be transformed into entities
// and implemented by usecases.

abstract class RuleSourceRemoteDatasource {
  Future<List<RuleSourceModel>> getOrganizedDataFromDb();
  Future<List<RuleSourceModel>> getRuleSourcesFromDb(user);
  Future<List<RuleModel>> getRulesFromDb();
  void fireStoreRuleSourceDelete(user, currentSourceId);
  void fireStoreRuleSourceUpdate(user, currentSource, currentSources);
  fireStoreDeleteUserCollection(user);
}

// Should the firestore be passed in to constructor and injected later?
class RuleSourceRemoteDatasourceImp implements RuleSourceRemoteDatasource {
  // Delete user collection clears all user saved data from their save
  // collection (not their credentials).
  // It is invoked on reset app to start button.
  @override
  fireStoreDeleteUserCollection(user) async {
    final _firestore = FirebaseFirestore.instance;
    var snapshots = await _firestore.collection(user).get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  // RuleSourceDelete removes the data associated with a user selection from
  // the user's save collection.
  // It is invoked when the user deactivates a selection button.
  @override
  void fireStoreRuleSourceDelete(user, currentSourceId) async {
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection(user).doc(currentSourceId).delete();
  }

  // RuleSourceUpdate updates the user's save collection, adding the selected
  // data from the activated selection button.
  // It is invoked when the user deactivates a selection button.
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

  // getOrganizedDataFromDb gets rule data from the db and returns a list of
  // RuleSource models
  // It is invoked when the user navigates in order to collect/organize
  // the proper data for display.
  @override
  Future<List<RuleSourceModel>> getOrganizedDataFromDb() async {
    List<RuleSourceModel> newSourceList = [];
    List allRulesList = [];
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection('rules').get().then((QuerySnapshot snapshot) {
      for (var e in snapshot.docs) {
        allRulesList.add(e.data());
      }
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

  // getRuleSourcesFromDb gets the data from the user's save collection for
  // use in displaying options upon navigation.
  // It returns a list of RuleSource models.
  // It is invoked when a user navigates.
  @override
  Future<List<RuleSourceModel>> getRuleSourcesFromDb(user) async {
    List<dynamic> sourceItems = <dynamic>[];
    List<RuleSourceModel> ruleSources = [];
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection(user).get().then((QuerySnapshot snapshot) {
      for (var f in snapshot.docs) {
        sourceItems.add(f.data());
      }
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

  // getRulesFromDb gets all of the rules data from the database for use in
  // final output rules display.
  // It returns a list of RuleSource models.
  // It is invoked when a user reaches the final selection page and navigates
  // to the display page.
  @override
  Future<List<RuleModel>> getRulesFromDb() async {
    List allRulesList = [];
    List<RuleModel> rulesList = [];
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection('rules').get().then((QuerySnapshot snapshot) {
      for (var e in snapshot.docs) {
        allRulesList.add(e.data());
      }
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
