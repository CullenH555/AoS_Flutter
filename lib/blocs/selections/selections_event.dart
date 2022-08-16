part of 'selections_bloc.dart';

abstract class SelectionsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// The events come from user interaction (like clicking a button).
// The event contains the current sources.
// It passes the current sources to the bloc for logic.
class LoadNextSelections extends SelectionsEvent {
  final List<Source> currentSources;
  @override
  LoadNextSelections({
    this.currentSources = const <Source>[],
  });

  @override
  List<Object> get props => [currentSources];
}

class ActivateSelection extends SelectionsEvent {
  final currentSource;
  final List<Source> currentSources;
  @override
  ActivateSelection({
    this.currentSource,
    this.currentSources = const <Source>[],
  });

  @override
  List<Object> get props => [currentSource, currentSources];
}

class DeactivateSelection extends SelectionsEvent {
  var currentSource;
  List<Source> currentSources = [];
  @override
  DeactivateSelection(
    this.currentSource,
    this.currentSources,
  );

  @override
  List<Object> get props => [currentSource, currentSources];
}

class DisplayOutput extends SelectionsEvent {
  List<Source> currentSources = [];
  DisplayOutput(this.currentSources);
  @override
  List<Object> get props => [currentSources];
}
