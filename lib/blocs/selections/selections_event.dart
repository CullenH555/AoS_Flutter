part of 'selections_bloc.dart';

abstract class SelectionsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// The events come from user interaction (like clicking a button).
// The event contains the current sources.
// It passes the current sources to the bloc for logic.
class LoadNextSelections extends SelectionsEvent {
  final List<RuleSource> currentSources;
  final String direction;
  @override
  LoadNextSelections({
    this.currentSources = const <RuleSource>[],
    required this.direction,
  });

  @override
  List<Object> get props => [currentSources];
}

class ActivateSelection extends SelectionsEvent {
  var currentSource;
  List<RuleSource> currentSources = [];
  @override
  ActivateSelection(
    this.currentSource,
    this.currentSources,
  );

  @override
  List<Object> get props => [currentSource, currentSources];
}

class DisplayOutput extends SelectionsEvent {
  @override
  List<Object> get props => [];
}
