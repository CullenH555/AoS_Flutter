import 'package:aos/data/repositories/repository.dart';
import 'package:aos/domain/entities/rule.dart';
import 'package:aos/domain/entities/rule_source.dart';
import 'package:aos/domain/generate_next_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRuleRepoImp extends Mock implements RuleRepoImp {}

void main() {
  MockRuleRepoImp mockRuleRepoImp = MockRuleRepoImp();
  group('nextPage', () {
    test(
      'should return a RuleSource list containing the next page button sources when direction is next',
      () async {
        // arrange
        String direction = 'next';
        List<RuleSource> currentSources = [
          RuleSource(
            sourceName: 'Heartwood',
            sourceFaction: 'Sylvaneth',
            sourceType: 'subfaction',
            nextSourceType: 'command',
            sourceActive: true,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'Winterleaf',
            sourceFaction: 'Sylvaneth',
            sourceType: 'subfaction',
            nextSourceType: 'command',
            sourceActive: false,
            sourceId: '',
          ),
        ];
        List<RuleSource> expectedResult = [
          RuleSource(
            sourceName: 'Legacy of Valor',
            sourceFaction: 'Sylvaneth',
            sourceType: 'command',
            nextSourceType: 'artifact',
            sourceActive: true,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'My Heart is ice',
            sourceFaction: 'Sylvaneth',
            sourceType: 'command',
            nextSourceType: 'artifact',
            sourceActive: false,
            sourceId: '',
          ),
        ];
        //act
        GenerateNextPage generateNextPage =
            GenerateNextPage(direction: direction);
        Future<List<RuleSource>> result =
            generateNextPage.generateNextPage(currentSources, direction);
        //assert
        expect(result, expectedResult);
      },
    );
    test(
      'should return a RuleSource list containing the previous page button sources when direction is previous',
      () async {
        // arrange
        String direction = 'previous';
        List<RuleSource> currentSources = [
          RuleSource(
            sourceName: 'Legacy of Valor',
            sourceFaction: 'Sylvaneth',
            sourceType: 'command',
            nextSourceType: 'artifact',
            sourceActive: true,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'My Heart is ice',
            sourceFaction: 'Sylvaneth',
            sourceType: 'command',
            nextSourceType: 'artifact',
            sourceActive: false,
            sourceId: '',
          ),
        ];
        List<RuleSource> expectedResult = [
          RuleSource(
            sourceName: 'Heartwood',
            sourceFaction: 'Sylvaneth',
            sourceType: 'subfaction',
            nextSourceType: 'command',
            sourceActive: true,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'Winterleaf',
            sourceFaction: 'Sylvaneth',
            sourceType: 'subfaction',
            nextSourceType: 'command',
            sourceActive: false,
            sourceId: '',
          ),
        ];
        //act
        GenerateNextPage generateNextPage =
            GenerateNextPage(direction: direction);
        Future<List<RuleSource>> result =
            generateNextPage.generateNextPage(currentSources, direction);
        //assert
        expect(result, expectedResult);
      },
    );
  });
}
