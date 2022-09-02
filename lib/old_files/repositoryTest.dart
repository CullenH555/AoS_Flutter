import '../domain/entities/rule_source.dart';

// The Repo organizes data from data sources for eventual use by the UI

abstract class Repo {
  List<RuleSource> getOrganizedDataFromRepo();
}

class RepoImp implements Repo {
  @override
  List<RuleSource> getOrganizedDataFromRepo() {
    List<RuleSource> newSourceList = [];
    for (var i = 0; i < dbData.length; i++) {
      String sourceName = dbData[i]['SourceName'].toString();
      String sourceFaction = dbData[i]['SourceFaction'].toString();
      String sourceType = dbData[i]['SourceType'].toString();
      String nextSourceType = dbData[i]['NextSourceType'].toString();
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
  List<RuleSource> oldSave = [];
}

// Pretend this came from a db.
var dbData = [
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
