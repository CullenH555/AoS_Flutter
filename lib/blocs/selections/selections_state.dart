part of 'selections_bloc.dart';

abstract class SelectionsState extends Equatable {
  const SelectionsState();
}

// The states are to update the UI in response to an event (show next page).
// The state receives the next sources from the Bloc.
// The state is used by the BlocBuilder.
class SelectionsInitial extends SelectionsState {
  SelectionsInitial({
    this.initSources = const <Source>[
      Source(
          sourceName: 'Sylvaneth',
          sourceFaction: 'sylvaneth',
          sourceType: 'faction',
          nextSourceType: 'subfaction',
          rulesList: []),
      Source(
          sourceName: 'Kharadron',
          sourceFaction: 'kharadron',
          sourceType: 'faction',
          nextSourceType: 'subfaction',
          rulesList: []),
    ],
  });
  final List<Source> initSources;
  final initSourceId = '';
  List<bool> initActive = [false, false];

  @override
  List<Object> get props => [initSources, initSourceId, initActive];
}

class NextSelectionsLoaded extends SelectionsState {
  const NextSelectionsLoaded(
      {this.nextSources = const <Source>[], this.active = const <bool>[]});
  final List<Source> nextSources;
  final List<bool> active;

  @override
  List<Object> get props => [nextSources];
}

class SelectionActivated extends SelectionsState {
  const SelectionActivated(
      {this.currentSource = const Source(),
      this.currentSources = const <Source>[],
      this.currentSourceId = '',
      this.active = const <bool>[]});
  final Source currentSource;
  final List<Source> currentSources;
  final currentSourceId;
  final List<bool> active;

  @override
  List<Object> get props =>
      [currentSource, currentSources, currentSourceId, active];
}

class SelectionDeactivated extends SelectionsState {
  const SelectionDeactivated(
      {this.currentSource = const Source(),
      this.currentSources = const <Source>[],
      this.currentSourceId = '',
      this.active = const <bool>[]});
  final Source currentSource;
  final List<Source> currentSources;
  final currentSourceId;
  final List<bool> active;

  @override
  List<Object> get props =>
      [currentSource, currentSources, currentSourceId, active];
}
