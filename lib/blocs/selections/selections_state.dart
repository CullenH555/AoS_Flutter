part of 'selections_bloc.dart';

abstract class SelectionsState extends Equatable {
  const SelectionsState();
}

// The states are to update the UI in response to an event (show next page).
// The state receives the next sources from the Bloc.
// The state is used by the BlocBuilder.
class SelectionsInitial extends SelectionsState {
  var sources = [
    RuleSource(
      sourceName: 'Sylvaneth',
      sourceFaction: 'sylvaneth',
      sourceType: 'faction',
      nextSourceType: 'subfaction',
      sourceActive: false,
      sourceId: '',
    ),
    RuleSource(
      sourceName: 'Kharadron',
      sourceFaction: 'kharadron',
      sourceType: 'faction',
      nextSourceType: 'subfaction',
      sourceActive: false,
      sourceId: '',
    ),
  ];
  SelectionsInitial(this.sources);

  @override
  List<Object> get props => [sources];
}

class NextSelectionsLoaded extends SelectionsState {
  const NextSelectionsLoaded({this.nextSources = const <RuleSource>[]});
  final List<RuleSource> nextSources;

  @override
  List<Object> get props => [nextSources];
}

class PreviousSelectionsLoaded extends SelectionsState {
  const PreviousSelectionsLoaded({this.previousSources = const <RuleSource>[]});
  final List<RuleSource> previousSources;
  @override
  List<Object> get props => [previousSources];
}

class SelectionActivated extends SelectionsState {
  var currentSource;
  List<RuleSource> currentSources;
  SelectionActivated(this.currentSource, this.currentSources);

  @override
  List<Object> get props => [currentSource, currentSources];
}

class SelectionDeactivated extends SelectionsState {
  var currentSource;
  List<RuleSource> currentSources;
  SelectionDeactivated(this.currentSource, this.currentSources);

  @override
  List<Object> get props => [currentSource, currentSources];
}

class OutputDisplayed extends SelectionsState {
  var rules;
  OutputDisplayed(this.rules);
  @override
  List<Object> get props => [rules];
}
