part of 'selections_bloc.dart';

abstract class SelectionsState extends Equatable {
  const SelectionsState();
}

// The states are to update the UI in response to an event (show next page).
// The state receives the next sources from the Bloc.
// The state is used by the BlocBuilder.
class SelectionsInitial extends SelectionsState {
  final List<RuleSource> sources = [
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
  SelectionsInitial(sources);

  @override
  List<Object> get props => [sources];
}

class NextSelectionsLoaded extends SelectionsState {
  final List<RuleSource> nextSources;
  const NextSelectionsLoaded({this.nextSources = const <RuleSource>[]});

  @override
  List<Object> get props => [nextSources];
}

class PreviousSelectionsLoaded extends SelectionsState {
  final List<RuleSource> previousSources;
  const PreviousSelectionsLoaded({this.previousSources = const <RuleSource>[]});
  @override
  List<Object> get props => [previousSources];
}

class SelectionActivated extends SelectionsState {
  final RuleSource currentSource;
  final List<RuleSource> currentSources;
  const SelectionActivated(this.currentSource, this.currentSources);

  @override
  List<Object> get props => [currentSource, currentSources];
}

class SelectionDeactivated extends SelectionsState {
  final RuleSource currentSource;
  final List<RuleSource> currentSources;
  const SelectionDeactivated(this.currentSource, this.currentSources);

  @override
  List<Object> get props => [currentSource, currentSources];
}

class OutputDisplayed extends SelectionsState {
  final List<Rule> rules;
  const OutputDisplayed(this.rules);
  @override
  List<Object> get props => [rules];
}
