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
  final List<bool> active;
  @override
  LoadNextSelections(
      {this.currentSources = const <Source>[], this.active = const <bool>[]});

  @override
  List<Object> get props => [currentSources, active];
}

class ActivateSelection extends SelectionsEvent {
  final Source currentSource;
  final List<Source> currentSources;
  final currentSourceId;
  final List<bool> active;
  @override
  ActivateSelection(
      {this.currentSource = const Source(),
      this.currentSources = const <Source>[],
      this.currentSourceId = '',
      this.active = const <bool>[]});

  @override
  List<Object> get props =>
      [currentSource, currentSources, currentSourceId, active];
}

class DeactivateSelection extends SelectionsEvent {
  final Source currentSource;
  final List<Source> currentSources;
  final currentSourceId;
  final List<bool> active;
  @override
  DeactivateSelection(
      {this.currentSource = const Source(),
      this.currentSources = const <Source>[],
      this.currentSourceId = '',
      this.active = const <bool>[]});

  @override
  List<Object> get props =>
      [currentSource, currentSources, currentSourceId, active];
}
