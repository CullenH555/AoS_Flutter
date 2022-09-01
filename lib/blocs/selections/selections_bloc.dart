import 'package:aos/domain/entities/ruleSource.dart';
import 'package:aos/domain/generate_next_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/rule.dart';
import '../../domain/entities/ruleSource.dart';
import '../../domain/generate_button_styler.dart';
import '../../domain/generate_display.dart';
import '../../domain/generate_save_delete.dart';
// uncomment below to init....
// import '../../domain/generate_initial_ruleData.dart';

part 'selections_event.dart';
part 'selections_state.dart';

// The Bloc receives an event and emits a state.
// The event is the click, containing the current sources.
// The logic is done by the domain (generateNextPage)
// The Bloc passe the event.currentSources to the domain logic.
// The Bloc receives the next sources from the domain logic.
// The Bloc passes/emits the nextSources to the state.
class SelectionsBloc extends Bloc<SelectionsEvent, SelectionsState> {
  SelectionsBloc()
      // Should SelectionsInitial be empty, have a loading animation,
      // or actually hold the initial data?
      : super(SelectionsInitial([
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
          RuleSource(
            sourceName: 'Blades of Khorne',
            sourceFaction: 'Blades of Khorne',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
          ),
        ])) {
    on<LoadNextSelections>(_onLoadNextSelections);
    on<ActivateSelection>(_onActivateSelection);
    on<DisplayOutput>(_onDisplayOutput);
  }

  void _onLoadNextSelections(
      LoadNextSelections event, Emitter<SelectionsState> emit) async {
    // Should this next line instantiate GNP with the direction and sources,
    // to be passed that way into the method calls?
    // Or should it be empty, and the direction and sources passed
    // directly into the method calls?
    GenerateNextPage nextPage = GenerateNextPage(direction: event.direction);
    // Should this next line of logic go into the GenerateNextPage.generateNextPage
    // call with event.direction passed in? Or here...
    if (event.direction == 'next') {
      List<RuleSource> sources = await nextPage.generateNextPage(
          event.currentSources, event.direction);
      emit(
        // Emit the new state: load event --> loaded state.
        NextSelectionsLoaded(nextSources: sources),
      );
    } else if (event.direction == 'previous') {
      List<RuleSource> sources = await nextPage.generateNextPage(
          event.currentSources, event.direction);
      emit(
        PreviousSelectionsLoaded(previousSources: sources),
      );
    }
  }

  void _onActivateSelection(
      ActivateSelection event, Emitter<SelectionsState> emit) async {
    // Below the event.data is passed directly to the method.
    GenerateButtonStyler styleButton = GenerateButtonStyler();
    List<RuleSource> buttonStyled = await styleButton.styleButton(
        event.currentSource, event.currentSources);
    GenerateNextSave save = GenerateNextSave();
    if (event.currentSource.sourceActive == true) {
      List<RuleSource> recordId =
          await save.generateNextSave(event.currentSource, buttonStyled);
      // To init rules database...
      //  var initDb = GenerateNextSave();
      //  var enterAllRecords = initDb.generateNextInit(event.currentSource);
      emit(
        // Emit the new state: load event --> loaded state.
        // To init rules database swap below 2 lines.
        // SelectionActivated(event.currentSource, enterAllRecords),
        SelectionActivated(event.currentSource, recordId),
      );
    } else if (event.currentSource.sourceActive == false) {
      List<RuleSource> editedSources =
          await save.generateNextSave(event.currentSource, buttonStyled);
      emit(
        // Emit the new state: load event --> loaded state.
        SelectionDeactivated(event.currentSource, editedSources),
      );
    }
  }

  void _onDisplayOutput(
      DisplayOutput event, Emitter<SelectionsState> emit) async {
    GenerateDisplay displayer = GenerateDisplay();
    List<Rule> theRules = await displayer.generateDisplay();
    emit(
      OutputDisplayed(theRules),
    );
  }
}
