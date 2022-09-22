import '../../data/repositories/repository.dart';
import '../entities/rule.dart';
import '../entities/rule_source.dart';

//  GenDisplay retrieves the rule data from the db based on the user's
//  save collection and returns an ordered list of Rule entities.
//  These will be used to display the ordered rules on the display page.
class GenDisplay {
  // For use in implementing GetIt Dependency Injection.
  final RuleRepository repository;
  GenDisplay({required this.repository});
  Future<List<Rule>> call({
    required String user,
  }) async {
    // Get the user's ruleSources from Db with which to compare.
    // For use in non GetIt implementation
    // RuleRepoImp repository = RuleRepoImp();
    List<RuleSource> sourceItems = await repository.getRuleSourcesFromDb(user);
    // At this point items should be:
    // [{sourceName: 'WoodAelves'}, {sourceName: 'Sylvaneth'}]
    // Get the rules from Db to compare with user's ruleSources choices.
    List<Rule> rulesItems = await repository.getRulesFromDb();
    // A list for each phase.
    // Create and insert the phase labels at the start of each phaseList.
    // TODO refactor the phase labels for cleaner display
    List<Rule> rulesMatchTurn = <Rule>[
      const Rule(
        ruleName: 'Out of Phase',
        ruleText: '',
        rulePhase: '',
        ruleSource: '',
        ruleFaction: '',
        ruleSourceType: '',
      ),
    ];
    List<Rule> rulesMatchHero = <Rule>[
      const Rule(
        ruleName: 'Hero Phase',
        ruleText: '',
        rulePhase: '',
        ruleSource: '',
        ruleFaction: '',
        ruleSourceType: '',
      ),
    ];
    List<Rule> rulesMatchMove = <Rule>[
      const Rule(
        ruleName: 'Movement Phase',
        ruleText: '',
        rulePhase: '',
        ruleSource: '',
        ruleFaction: '',
        ruleSourceType: '',
      ),
    ];
    List<Rule> rulesMatchShoot = <Rule>[
      const Rule(
        ruleName: 'Shooting Phase',
        ruleText: '',
        rulePhase: '',
        ruleSource: '',
        ruleFaction: '',
        ruleSourceType: '',
      ),
    ];
    List<Rule> rulesMatchCharge = <Rule>[
      const Rule(
        ruleName: 'Charge Phase',
        ruleText: '',
        rulePhase: '',
        ruleSource: '',
        ruleFaction: '',
        ruleSourceType: '',
      ),
    ];
    List<Rule> rulesMatchCombat = <Rule>[
      const Rule(
        ruleName: 'Combat Phase',
        ruleText: '',
        rulePhase: '',
        ruleSource: '',
        ruleFaction: '',
        ruleSourceType: '',
      ),
    ];
    List<Rule> rulesMatchBattleshock = <Rule>[
      const Rule(
        ruleName: 'Battleshock Phase',
        ruleText: '',
        rulePhase: '',
        ruleSource: '',
        ruleFaction: '',
        ruleSourceType: '',
      ),
    ];
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
