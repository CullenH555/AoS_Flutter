import 'package:flutter/material.dart';
import '../../domain/entities/rule.dart';

// Page for displaying rules list of user choices,
// ordered by game phase.
class DisplayPage extends StatelessWidget {
  DisplayPage(this.rules);
  List<Rule> rules;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: rules.length, // "consolidated rulesList".length
      itemBuilder: (context, index) {
        var ruleName = rules[index].ruleName;
        var ruleText = rules[index].ruleText;
        // At this point items should be:
        // [{sourceName: 'WoodAelves'}, {sourceName: 'Sylvaneth'}]
        // Or work with "consolidated rulesList"
        return Text(
          '$ruleName: $ruleText',
        );
      },
    );
  }
}
