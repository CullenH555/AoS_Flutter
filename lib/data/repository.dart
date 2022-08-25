import 'package:aos/data/get_rules_from_db.dart';

import '../domain/entities/rule.dart';
import 'package:aos/domain/entities/ruleSource.dart';
// The Repo organizes data from data sources for eventual use by the UI

abstract class Repo {
  Future<List<RuleSource>> getOrganizedDataFromRepo();
}

class RepoImp implements Repo {
  @override
  Future<List<RuleSource>> getOrganizedDataFromRepo() async {
    List<RuleSource> newSourceList = [];
    var getRules = GetRulesFromDb();
    var dbData = await getRules.getRulesFromDb();
    String sourceType = '';
    String nextSourceType = '';
    for (var i = 0; i < dbData.length; i++) {
      if (dbData[i]['ruleSourceType'].toString() == 'Unit ability') {
        sourceType = 'warscroll';
        nextSourceType = 'battalion';
      } else if (dbData[i]['ruleSourceType'].toString() == 'Artifact') {
        sourceType = 'artifact';
        nextSourceType = 'warscroll';
      } else if (dbData[i]['ruleSourceType'].toString() ==
              'Subfaction Ability' ||
          dbData[i]['ruleSourceType'].toString() == 'Subfaction ability') {
        sourceType = 'subfaction';
        nextSourceType = 'command';
      } else if (dbData[i]['ruleSourceType'].toString() ==
          'Allegiance ability') {
        sourceType = 'faction';
        nextSourceType = 'subfaction';
      } else if (dbData[i]['ruleSourceType'].toString() ==
          'Battalion ability') {
        sourceType = 'battalion';
        nextSourceType = 'end';
      } else if (dbData[i]['ruleSourceType'].toString() == 'Command Trait') {
        sourceType = 'command';
        nextSourceType = 'artifact';
      } else {
        sourceType = 'other';
        nextSourceType = 'other';
      }
      String sourceName = dbData[i]['ruleSource'].toString();
      String sourceFaction = dbData[i]['ruleFaction'].toString();
      RuleSource newSource = RuleSource(
        sourceName: sourceName,
        sourceFaction: sourceFaction,
        sourceType: sourceType,
        nextSourceType: nextSourceType,
      );
      newSourceList.add(newSource);
    }
    //  print('newSourceList after chugging through db rules: ');
    //  print(newSourceList);
    return newSourceList;
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
