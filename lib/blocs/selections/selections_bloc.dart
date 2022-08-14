import 'dart:async';
import 'package:aos/domain/entities/source.dart';
import 'package:aos/domain/generate_next_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/source.dart';
import '../../domain/generate_button_styler.dart';
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
  SelectionsBloc() : super(SelectionsInitial()) {
    on<LoadNextSelections>(_onLoadNextSelections);
    on<ActivateSelection>(_onActivateSelection);
    on<DeactivateSelection>(_onDeactivateSelection);
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
    var styleButton = GenerateButtonStyler(active: event.active);
    print("inside activate before we style the button active is: ");
    print(event.active);
    var buttonStyled = await styleButton.styleButton(
        event.currentSource, event.currentSources, event.active);
    var sourcesPassed = await styleButton.passSources(event.currentSources);
    var save = GenerateNextSave();
    save.generateNextSave(event.currentSource);
    emit(
      // Emit the new state: load event --> loaded state.
      SelectionActivated(
          currentSource: event.currentSource,
          currentSources: sourcesPassed,
          active: buttonStyled),
    );
  }

  void _onDeactivateSelection(
      DeactivateSelection event, Emitter<SelectionsState> emit) async {
    var styleButton = GenerateButtonStyler(active: event.active);
    print("inside activate before we style the button active is: ");
    print(event.active);
    var buttonStyled = await styleButton.styleButton(
        event.currentSource, event.currentSources, event.active);
    var sourcesPassed = await styleButton.passSources(event.currentSources);
    //   var save = GenerateNextSave();
    //   save.generateNextSave(event.currentSource);
    emit(
      // Emit the new state: load event --> loaded state.
      SelectionDeactivated(
          currentSource: event.currentSource,
          currentSources: sourcesPassed,
          active: buttonStyled),
    );
  }
}
