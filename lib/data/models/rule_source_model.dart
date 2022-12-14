import 'package:aos_playmat_builder_flutter/domain/entities/rule_source.dart';

// RuleSourceModel is returned by the Datasource
// It is used by the repository to ensure ruleSource entity
class RuleSourceModel extends RuleSource {
  RuleSourceModel({
    required String sourceName,
    required String sourceFaction,
    required String sourceType,
    required String nextSourceType,
    required bool sourceActive,
    required String sourceId,
  }) : super(
            sourceName: sourceName,
            sourceFaction: sourceFaction,
            sourceType: sourceType,
            nextSourceType: nextSourceType,
            sourceActive: sourceActive,
            sourceId: sourceId);

  factory RuleSourceModel.fromJson(Map<String, dynamic> json) {
    return RuleSourceModel(
        sourceName: json['sourceName'],
        sourceFaction: json['sourceFaction'],
        sourceType: json['sourceType'],
        nextSourceType: json['nextSourceType'],
        sourceActive: json['sourceActive'],
        sourceId: json['sourceId']);
  }
  Map<String, dynamic> toJson() {
    return {
      "nextSourceType": "nextType",
      "sourceActive": true,
      "sourceFaction": "Faction",
      "sourceId": "1",
      "sourceName": "Name",
      "sourceType": "Type"
    };
  }
}
