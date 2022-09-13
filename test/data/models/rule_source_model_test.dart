import 'dart:convert';

import 'package:aos/data/models/rule_source_model.dart';
import 'package:aos/domain/entities/rule_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  RuleSourceModel tRuleSourceModel = RuleSourceModel(
    sourceName: 'Name',
    sourceFaction: 'Faction',
    sourceType: 'Type',
    nextSourceType: 'nextType',
    sourceActive: true,
    sourceId: '1',
  );

  test(
    'should be a subclass of RuleSource entity',
    () async {
      //assert
      expect(tRuleSourceModel, isA<RuleSource>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model when the Json is well formed',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            jsonDecode(fixture('rule_source.json'));
        //act
        final result = RuleSourceModel.fromJson(jsonMap);
        //assert
        expect(result, tRuleSourceModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a Json map containing the proper data',
      () async {
        //act
        final result = tRuleSourceModel.toJson();
        //assert
        final expectedMap = {
          "nextSourceType": "nextType",
          "sourceActive": true,
          "sourceFaction": "Faction",
          "sourceId": "1",
          "sourceName": "Name",
          "sourceType": "Type"
        };
        expect(result, expectedMap);
      },
    );
  });
}
