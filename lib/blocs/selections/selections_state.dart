part of 'selections_bloc.dart';

abstract class SelectionsState extends Equatable {
  const SelectionsState();
}

// The states are to update the UI in response to an event (show next page).
// The state receives the next sources from the Bloc.
// The state is used by the BlocBuilder.
class SelectionsInitial extends SelectionsState {
  var sources = [
    Source(
      sourceName: 'Sylvaneth',
      sourceFaction: 'sylvaneth',
      sourceType: 'faction',
      nextSourceType: 'subfaction',
      sourceActive: false,
      sourceId: '',
    ),
    Source(
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
  const NextSelectionsLoaded({this.nextSources = const <Source>[]});
  final List<Source> nextSources;

  @override
  List<Object> get props => [nextSources];
}

class SelectionActivated extends SelectionsState {
  var currentSource;
  List<Source> currentSources;
  SelectionActivated(this.currentSource, this.currentSources);

  @override
  List<Object> get props => [currentSource, currentSources];
}

class SelectionDeactivated extends SelectionsState {
  var currentSource;
  List<Source> currentSources;
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
