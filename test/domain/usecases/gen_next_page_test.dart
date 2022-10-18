import 'package:aos/data/repositories/repository.dart';
import 'package:aos/domain/entities/rule.dart';
import 'package:aos/domain/entities/rule_source.dart';
import 'package:aos/domain/usecases/gen_next_page.dart';
import 'package:aos/domain/usecases/gen_next_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRuleRepository extends Mock implements RuleRepository {}

void main() {
  MockRuleRepository mockRuleRepository;
  GenNextPage usecase;
  mockRuleRepository = MockRuleRepository();
  usecase = GenNextPage(repository: mockRuleRepository);

  setUp(() {
    mockRuleRepository = MockRuleRepository();
    usecase = GenNextPage(repository: mockRuleRepository);
  });

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

  test(
    'should return a RuleSource list containing the next page button sources when direction is next',
    () async {
      // arrange
      String direction = 'next';
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
      when(mockRuleRepository.getOrganizedDataFromDb())
          .thenAnswer((_) async => expectedResult);
      //act
      GenNextPage generateNextPage =
          GenNextPage(repository: mockRuleRepository);
      List<RuleSource> result = await generateNextPage(
          currentSources: currentSources, direction: direction, user: 'user');
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
      when(mockRuleRepository.getOrganizedDataFromDb())
          .thenAnswer((_) async => expectedResult);
      //act
      GenNextPage generateNextPage =
          GenNextPage(repository: mockRuleRepository);
      List<RuleSource> result = await generateNextPage(
          currentSources: currentSources, direction: direction, user: 'user');
      //assert
      expect(result, expectedResult);
    },
  );
}
