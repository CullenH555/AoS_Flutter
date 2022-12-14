import 'package:flutter/material.dart';
import 'package:aos_playmat_builder_flutter/domain/entities/rule.dart';
import 'package:aos_playmat_builder_flutter/presentation/widgets/alert_dialogue.dart';

// Page for displaying rules list of user choices, ordered by game phase.
// It is the "final" page, and navigating from it clears the user's save data
// and returns the user to the first selection page to start a new list.
class DisplayPage extends StatelessWidget {
  const DisplayPage(this.rules, this.user);
  final List<Rule> rules;
  final String user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: 0,
          ),
          child: Text(
            'Rules By Phase: ',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Expanded(
          child: SizedBox.expand(
              child: FractionallySizedBox(
            widthFactor: .95,
            heightFactor: 1,
            alignment: FractionalOffset.center,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: rules.length, // "consolidated rulesList".length
              itemBuilder: (context, index) {
                var ruleName = rules[index].ruleName;
                var ruleText = rules[index].ruleText;
                // At this point items should be:
                // [{sourceName: 'WoodAelves'}, {sourceName: 'Sylvaneth'}]
                // Below is some presentation logic to format the display.
                // It checks for the phase labels and styles them accordingly.
                if (ruleName == 'Out of Phase' ||
                    ruleName == 'Hero Phase' ||
                    ruleName == 'Movement Phase' ||
                    ruleName == 'Shooting Phase' ||
                    ruleName == 'Charge Phase' ||
                    ruleName == 'Combat Phase' ||
                    ruleName == 'Battleshock Phase') {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 20.0),
                    child: Text(
                      '$ruleName: $ruleText',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10.0),
                    child: Text(
                      '$ruleName: $ruleText',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                }
              },
            ),
          )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 0,
          ),
          child: FloatingActionButton(
            heroTag: null,
            child: const Icon(Icons.arrow_back),
            onPressed: () {
              AlertDialogue alertDialogue = AlertDialogue(user: user);
              alertDialogue.showAlertDialogue(context);
            },
          ),
        ),
      ],
    );
  }
}

// TODO refactor back button from display page?
// Currently it loads the hardcoded initial sources.
// It verifies that the user wants to delete project.
// It clears the user's collection.
