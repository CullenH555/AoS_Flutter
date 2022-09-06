import 'package:flutter/material.dart';
import '../../domain/entities/rule.dart';
import '../../presentation/widgets/alert_dialogue.dart';

// Page for displaying rules list of user choices,
// ordered by game phase.
class DisplayPage extends StatelessWidget {
  DisplayPage(this.rules);
  List<Rule> rules;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Rules By Phase: '),
        Expanded(
          child: SizedBox.expand(
              child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.5,
            alignment: FractionalOffset.center,
            child: ListView.builder(
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
            ),
          )),
        ),
        FloatingActionButton(
          heroTag: null,
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            AlertDialogue alertDialogue = AlertDialogue();
            alertDialogue.showAlertDialogue(context);
          },
        )
      ],
    );
  }
}

// TODO refactor back button from display page.
// Currently it loads the hardcoded initial sources.
// It verifies that the user wants to delete project.
// It clears the user's collection.
