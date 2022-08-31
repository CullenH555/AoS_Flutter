import 'package:aos/domain/generate_user_actions.dart';
import 'package:aos/old_files/generate_current_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'entities/ruleSource.dart';

class GenerateDisplay extends Equatable {
  @override
  List<Object?> get props => [];

  //  Generating the display retrieves the data from the db and returns a list of rules.
  generateDisplay() async {
    var getUser = GenerateUserActions();
    var user = await getUser.getCurrentUser();
    var sourceItems = <dynamic>[];
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection(user).get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach(
        // add data to the list
        (f) => sourceItems.add(f.data()),
      );
    });
    // At this point items should be:
    // [{sourceName: 'WoodAelves'}, {sourceName: 'Sylvaneth'}]
    var rulesItems = <dynamic>[];
    await _firestore.collection('rules').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach(
        (g) => rulesItems.add(g.data()),
      );
    });
    var rulesMatchTurn = <dynamic>[];
    var rulesMatchHero = <dynamic>[];
    var rulesMatchMove = <dynamic>[];
    var rulesMatchShoot = <dynamic>[];
    var rulesMatchCharge = <dynamic>[];
    var rulesMatchCombat = <dynamic>[];
    var rulesMatchBattleshock = <dynamic>[];
    for (var i = 0; i < sourceItems.length; i++) {
      for (var j = 0; j < rulesItems.length; j++) {
        if (sourceItems[i]['sourceName'] == rulesItems[j]['ruleSource']) {
          if (rulesItems[j]['rulePhase'] == 'turn') {
            rulesMatchTurn.add(rulesItems[j]);
          } else if (rulesItems[j]['rulePhase'] == 'hero') {
            rulesMatchHero.add(rulesItems[j]);
          } else if (rulesItems[j]['rulePhase'] == 'move') {
            rulesMatchMove.add(rulesItems[j]);
          } else if (rulesItems[j]['rulePhase'] == 'shoot') {
            rulesMatchShoot.add(rulesItems[j]);
          } else if (rulesItems[j]['rulePhase'] == 'charge') {
            rulesMatchCharge.add(rulesItems[j]);
          } else if (rulesItems[j]['rulePhase'] == 'combat') {
            rulesMatchCombat.add(rulesItems[j]);
          } else if (rulesItems[j]['rulePhase'] == 'battleshock') {
            rulesMatchBattleshock.add(rulesItems[j]);
          }
        }
      }
    }
    var rulesListOrdered = rulesMatchTurn +
        rulesMatchHero +
        rulesMatchMove +
        rulesMatchShoot +
        rulesMatchCharge +
        rulesMatchCombat +
        rulesMatchBattleshock;
    var seen = Set<String>();
    Iterable rulesList =
        rulesListOrdered.where((rule) => seen.add(rule['ruleName'])).toList();
    //   var rulesList = rulesListOrdered.toSet().toList();
    //   print(rulesList.length);
    return rulesList;
  }
}
