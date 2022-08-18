import 'dart:async';
import 'package:aos/domain/entities/source.dart';
import 'package:aos/domain/generate_next_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/rule.dart';
import '../../domain/entities/source.dart';
import '../../domain/generate_button_styler.dart';
import '../../domain/generate_display.dart';
import '../../domain/generate_next_save.dart';
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
      : super(SelectionsInitial([
          Source(
              sourceName: 'Sylvaneth',
              sourceFaction: 'sylvaneth',
              sourceType: 'faction',
              nextSourceType: 'subfaction',
              sourceActive: false,
              sourceId: '',
              rulesList: []),
          Source(
            sourceName: 'Kharadron',
            sourceFaction: 'kharadron',
            sourceType: 'faction',
            nextSourceType: 'subfaction',
            sourceActive: false,
            sourceId: '',
            rulesList: [],
          ),
        ])) {
    on<LoadNextSelections>(_onLoadNextSelections);
    on<ActivateSelection>(_onActivateSelection);
    on<DeactivateSelection>(_onDeactivateSelection);
    on<DisplayOutput>(_onDisplayOutput);
  }
  void _onLoadNextSelections(
      LoadNextSelections event, Emitter<SelectionsState> emit) async {
    var nextPage = GenerateNextPage();
    var sources = await nextPage.generateNextPage(event.currentSources);
    emit(
      // Emit the new state: load event --> loaded state.
      NextSelectionsLoaded(nextSources: sources),
    );
  }

  void _onActivateSelection(
      ActivateSelection event, Emitter<SelectionsState> emit) async {
    var styleButton = GenerateButtonStyler();
    var buttonStyled = await styleButton.styleButton(
        event.currentSource, event.currentSources);
    var save = GenerateNextSave();
    var recordId =
        await save.generateNextSave(event.currentSource, buttonStyled);
    emit(
      // Emit the new state: load event --> loaded state.
      SelectionActivated(event.currentSource, recordId),
    );
  }

  void _onDeactivateSelection(
      DeactivateSelection event, Emitter<SelectionsState> emit) async {
    var styleButton = GenerateButtonStyler();
    var buttonStyled = await styleButton.styleButton(
        event.currentSource, event.currentSources);
    var delete = GenerateNextSave();
    var editedSources =
        await delete.generateNextSave(event.currentSource, buttonStyled);
    emit(
      // Emit the new state: load event --> loaded state.
      SelectionDeactivated(event.currentSource, editedSources),
    );
  }

  void _onDisplayOutput(
      DisplayOutput event, Emitter<SelectionsState> emit) async {
    var displayer = GenerateDisplay();
    var theRules = await displayer.generateDisplay();
    print('coming back from generateDisplay: ');
    print(theRules);
    emit(
      OutPutDisplay(theRules),
    );
  }
}
