import 'package:aos/blocs/login/login_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/selections/selections_bloc.dart';

class DisplayPage extends StatelessWidget {
  DisplayPage(this.rules);
  var rules;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      // How to unpack [{rule: rulesList[]}]
      // Maybe use firestore query to return a list of all rulesLists.
      // Then use "consolidated rulesList" to populate.
      itemCount: rules.length, // "consolidated rulesList".length
      itemBuilder: (context, index) {
        var ruleName = rules[index]['ruleName'];
        var ruleText = rules[index]['ruleText'];
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
