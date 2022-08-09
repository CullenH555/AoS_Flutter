import 'package:equatable/equatable.dart';

class Rule extends Equatable {
  const Rule(this.ruleName, this.ruleText, this.rulePhase);

  final String ruleName;
  final String ruleText;
  final String rulePhase;

  @override
  List<Object> get props => [ruleName, ruleText, rulePhase];
}
