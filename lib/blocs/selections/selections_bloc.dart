import 'dart:async';
import 'package:aos/domain/entities/source.dart';
import 'package:aos/domain/generate_next_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/source.dart';

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
}
