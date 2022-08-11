part of 'selections_bloc.dart';

abstract class SelectionsEvent extends Equatable {
  const SelectionsEvent();

  @override
  List<Object> get props => [];
}

// The events come from user interaction (like clicking a button).
// The event contains the current sources.
// It passes the current sources to the bloc for logic.
class LoadNextSelections extends SelectionsEvent {
  final List<Source> currentSources;

  const LoadNextSelections({this.currentSources = const <Source>[]});

  @override
  List<Object> get props => [currentSources];
}
