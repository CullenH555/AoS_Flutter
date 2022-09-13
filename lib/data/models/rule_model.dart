import 'package:aos/domain/entities/rule_source.dart';

import '../../domain/entities/rule.dart';

class RuleModel extends Rule {
  RuleModel({
    required String ruleName,
    required String ruleFaction,
    required String ruleSource,
    required String ruleSourceType,
    required String rulePhase,
    required String ruleText,
  }) : super(
          ruleName: ruleName,
          ruleFaction: ruleFaction,
          ruleSource: ruleSource,
          ruleSourceType: ruleSourceType,
          rulePhase: rulePhase,
          ruleText: ruleText,
        );

  factory RuleModel.fromJson(Map<String, dynamic> json) {
    return RuleModel(
        ruleName: json['ruleName'],
        ruleFaction: json['ruleFaction'],
        ruleSourceType: json['ruleSourceType'],
        ruleSource: json['ruleSource'],
        rulePhase: json['rulePhase'],
        ruleText: json['ruleText']);
  }
  Map<String, dynamic> toJson() {
    return {
      "ruleSource": "Source",
      "rulePhase": "Phase",
      "ruleFaction": "Faction",
      "ruleText": "Text",
      "ruleName": "Name",
      "ruleType": "Type"
    };
  }
}
