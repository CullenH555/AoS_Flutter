part of 'selections_bloc.dart';

abstract class SelectionsState extends Equatable {
  const SelectionsState();
}

// The states are to update the UI in response to an event (show next page).
// The state receives the next sources from the Bloc.
// The state is used by the BlocBuilder.
class SelectionsInitial extends SelectionsState {
  const SelectionsInitial({
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

  @override
  List<Object> get props => [initSources];
}

class NextSelectionsLoaded extends SelectionsState {
  const NextSelectionsLoaded({this.nextSources = const <Source>[]});
  final List<Source> nextSources;

  @override
  List<Object> get props => [nextSources];
}
