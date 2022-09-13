import 'package:aos/data/datasources/rule_source_remote_datasource.dart';
import 'package:aos/data/models/rule_source_model.dart';
import 'package:aos/data/repositories/repository.dart';
import 'package:aos/domain/entities/rule.dart';
import 'package:aos/domain/entities/rule_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRuleSourceRemoteDatasource extends Mock
    implements RuleSourceRemoteDatasource {}

void main() {
  RuleRepoImp repository;
  MockRuleSourceRemoteDatasource mockRuleSourceRemoteDatasource;
  setUp(() {
    mockRuleSourceRemoteDatasource = MockRuleSourceRemoteDatasource();
    repository = RuleRepoImp(remoteDatasource: mockRuleSourceRemoteDatasource);
  });
  group('getRuleSourcesFromDb', () {
    final tRuleSourceModel = [
      RuleSourceModel(
          sourceName: 'sourceName',
          sourceFaction: 'sourceFaction',
          sourceType: 'sourceType',
          nextSourceType: 'nextSourceType',
          sourceActive: false,
          sourceId: 'sourceId')
    ];
    test(
      'should return remote data when call to remote datasource is successful',
      () async {
        mockRuleSourceRemoteDatasource = MockRuleSourceRemoteDatasource();
        repository =
            RuleRepoImp(remoteDatasource: mockRuleSourceRemoteDatasource);
        RuleSource tRuleSource = RuleSource(
          sourceName: 'sourceName',
          sourceFaction: 'sourceFaction',
          sourceType: 'sourceType',
          nextSourceType: 'nextSourceType',
          sourceActive: false,
          sourceId: 'sourceId',
        );
        // arrange
        when(mockRuleSourceRemoteDatasource.getRuleSourcesFromDb())
            .thenAnswer((_) async => tRuleSourceModel);
        //act
        final result = repository.getRuleSourcesFromDb();
        //assert
        expect(result, tRuleSource);
      },
    );
  });
}
