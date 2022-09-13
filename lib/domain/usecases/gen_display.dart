import '../../data/repositories/repository.dart';
import '../entities/rule.dart';
import '../entities/rule_source.dart';

//  Generating the display retrieves the data from the db and returns a list of rules.
class GenDisplay {
  Future<List<Rule>> call({
    required String user,
  }) async {
    // Get the user's ruleSources from Db with which to compare.
    RuleRepoImp repository = RuleRepoImp();
    List<RuleSource> sourceItems = await repository.getRuleSourcesFromDb(user);
    // At this point items should be:
    // [{sourceName: 'WoodAelves'}, {sourceName: 'Sylvaneth'}]
    // Get the rules from Db to compare with user's ruleSources choices.
    List<Rule> rulesItems = await repository.getRulesFromDb();
    // An list for each phase.
    List<Rule> rulesMatchTurn = <Rule>[];
    List<Rule> rulesMatchHero = <Rule>[];
    List<Rule> rulesMatchMove = <Rule>[];
    List<Rule> rulesMatchShoot = <Rule>[];
    List<Rule> rulesMatchCharge = <Rule>[];
    List<Rule> rulesMatchCombat = <Rule>[];
    List<Rule> rulesMatchBattleshock = <Rule>[];
    // Match rules based on phase, to arrange in order.
    for (var i = 0; i < sourceItems.length; i++) {
      for (var j = 0; j < rulesItems.length; j++) {
        if (sourceItems[i].sourceName == rulesItems[j].ruleSource) {
          if (rulesItems[j].rulePhase == 'turn') {
            rulesMatchTurn.add(rulesItems[j]);
          } else if (rulesItems[j].rulePhase == 'hero') {
            rulesMatchHero.add(rulesItems[j]);
          } else if (rulesItems[j].rulePhase == 'move') {
            rulesMatchMove.add(rulesItems[j]);
          } else if (rulesItems[j].rulePhase == 'shoot') {
            rulesMatchShoot.add(rulesItems[j]);
          } else if (rulesItems[j].rulePhase == 'charge') {
            rulesMatchCharge.add(rulesItems[j]);
          } else if (rulesItems[j].rulePhase == 'combat') {
            rulesMatchCombat.add(rulesItems[j]);
          } else if (rulesItems[j].rulePhase == 'battleshock') {
            rulesMatchBattleshock.add(rulesItems[j]);
          }
        }
      }
    }
    // Combine the sub lists in order of phase.
    List<Rule> rulesListOrdered = rulesMatchTurn +
        rulesMatchHero +
        rulesMatchMove +
        rulesMatchShoot +
        rulesMatchCharge +
        rulesMatchCombat +
        rulesMatchBattleshock;
    // Ensure that only one copy of each rule is added.
    Set<String> seen = <String>{};
    List<Rule> rulesList =
        rulesListOrdered.where((rule) => seen.add(rule.ruleName)).toList();
    return rulesList;
  }
}
