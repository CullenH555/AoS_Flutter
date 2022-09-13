import 'package:equatable/equatable.dart';

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
