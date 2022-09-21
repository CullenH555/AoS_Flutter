import 'package:equatable/equatable.dart';

// Entity of rule.
// Contains the data needed for selecting, organizing, and displaying rules.
// It also contains all info necessary for a RuleSource.
// It is used to create rule sources, and to order and display final app output.
class Rule extends Equatable {
  final String ruleName;
  final String ruleText;
  final String rulePhase;
  final String ruleSource;
  final String ruleSourceType;
  final String ruleFaction;
  const Rule({
    this.ruleName = '',
    this.ruleText = '',
    this.rulePhase = '',
    this.ruleSource = '',
    this.ruleFaction = '',
    this.ruleSourceType = '',
  });

  @override
  List<Object> get props =>
      [ruleName, ruleText, rulePhase, ruleSource, ruleFaction, ruleSourceType];
}
