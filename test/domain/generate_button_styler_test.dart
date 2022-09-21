import 'package:aos/domain/entities/rule_source.dart';
import 'package:aos/domain/usecases/old_usecases/generate_button_styler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenerateButtonStyler', () {
    test(
      'should return a RuleSource list with the currentSource activity set to true when passed in as false.',
      () {
        // arrange
        RuleSource currentSource = RuleSource(
          sourceName: 'Sylvaneth',
          sourceFaction: 'Sylvaneth',
          sourceType: 'faction',
          nextSourceType: 'subfaction',
          sourceActive: false,
          sourceId: '',
        );
        List<RuleSource> currentSources = [
          RuleSource(
            sourceName: 'Sylvaneth',
            sourceFaction: 'Sylvaneth',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'Kharadron Overlords',
            sourceFaction: 'Kharadron Overlords',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'Wood Aelves',
            sourceFaction: 'Wood Aelves',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
          ),
        ];
        List<RuleSource> expectedResult = [
          RuleSource(
            sourceName: 'Sylvaneth',
            sourceFaction: 'Sylvaneth',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: true,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'Kharadron Overlords',
            sourceFaction: 'Kharadron Overlords',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'Wood Aelves',
            sourceFaction: 'Wood Aelves',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
          ),
        ];
        //act
        GenerateButtonStyler generateButtonStyler = GenerateButtonStyler();
        var result =
            generateButtonStyler.styleButton(currentSource, currentSources);
        //assert
        expect(result, expectedResult);
      },
    );
    test(
      'should return a RuleSource list with the currentSource activity set to false when passed in as true.',
      () {
        // arrange
        RuleSource currentSource = RuleSource(
          sourceName: 'Sylvaneth',
          sourceFaction: 'Sylvaneth',
          sourceType: 'faction',
          nextSourceType: 'subfaction',
          sourceActive: true,
          sourceId: '',
        );
        List<RuleSource> currentSources = [
          RuleSource(
            sourceName: 'Sylvaneth',
            sourceFaction: 'Sylvaneth',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: true,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'Kharadron Overlords',
            sourceFaction: 'Kharadron Overlords',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'Wood Aelves',
            sourceFaction: 'Wood Aelves',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
          ),
        ];
        List<RuleSource> expectedResult = [
          RuleSource(
            sourceName: 'Sylvaneth',
            sourceFaction: 'Sylvaneth',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'Kharadron Overlords',
            sourceFaction: 'Kharadron Overlords',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
          ),
          RuleSource(
            sourceName: 'Wood Aelves',
            sourceFaction: 'Wood Aelves',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
          ),
        ];
        //act
        GenerateButtonStyler generateButtonStyler = GenerateButtonStyler();
        var result =
            generateButtonStyler.styleButton(currentSource, currentSources);
        //assert
        expect(result, expectedResult);
      },
    );
  });
}
