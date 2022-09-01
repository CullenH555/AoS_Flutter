import 'package:equatable/equatable.dart';

class Rule extends Equatable {
  const Rule(this.ruleName, this.ruleText, this.rulePhase, this.ruleSource);

  final String ruleName;
  final String ruleText;
  final String rulePhase;
  final String ruleSource;

  @override
  List<Object> get props => [ruleName, ruleText, rulePhase, ruleSource];
}
