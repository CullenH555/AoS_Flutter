part of 'selections_bloc.dart';

abstract class SelectionsState extends Equatable {
  const SelectionsState();
}

// The states are to update the UI in response to an event (show next page).
// The state receives the next sources from the Bloc.
// The state is used by the BlocBuilder.
class SelectionsInitial extends SelectionsState {
  final String user;
  final List<RuleSource> sources = [
    RuleSource(
      sourceName: 'Sylvaneth',
      sourceFaction: 'Sylvaneth',
      sourceType: 'faction',
      nextSourceType: 'subfaction',
      sourceActive: false,
      sourceId: '',
    ),
    RuleSource(
      sourceName: 'Kharadron Overlords',
      sourceFaction: 'Kharadron Overlords',
      sourceType: 'faction',
      nextSourceType: 'subfaction',
      sourceActive: false,
      sourceId: '',
    ),
    RuleSource(
      sourceName: 'Wood Aelves',
      sourceFaction: 'Wood Aelves',
      sourceType: 'faction',
      nextSourceType: 'subfaction',
      sourceActive: false,
      sourceId: '',
    ),
    RuleSource(
      sourceName: 'Blades of Khorne',
      sourceFaction: 'Blades of Khorne',
      sourceType: 'faction',
      nextSourceType: 'subfaction',
      sourceActive: false,
      sourceId: '',
    ),
  ];
  SelectionsInitial(sources, this.user);

  @override
  List<Object> get props => [sources];
}

class InitialSelectionsLoaded extends SelectionsState {
  late final String user;
  final List<RuleSource> initialSources = [
    RuleSource(
      sourceName: 'Sylvaneth',
      sourceFaction: 'Sylvaneth',
      sourceType: 'faction',
      nextSourceType: 'subfaction',
      sourceActive: false,
      sourceId: '',
    ),
    RuleSource(
      sourceName: 'Kharadron Overlords',
      sourceFaction: 'Kharadron Overlords',
      sourceType: 'faction',
      nextSourceType: 'subfaction',
      sourceActive: false,
      sourceId: '',
    ),
    RuleSource(
      sourceName: 'Wood Aelves',
      sourceFaction: 'Wood Aelves',
      sourceType: 'faction',
      nextSourceType: 'subfaction',
      sourceActive: false,
      sourceId: '',
    ),
    RuleSource(
      sourceName: 'Blades of Khorne',
      sourceFaction: 'Blades of Khorne',
      sourceType: 'faction',
      nextSourceType: 'subfaction',
      sourceActive: false,
      sourceId: '',
    ),
  ];
  @override
  List<Object> get props => [];
}

class NextSelectionsLoaded extends SelectionsState {
  final List<RuleSource> nextSources;
  final String user;
  const NextSelectionsLoaded(
      {this.nextSources = const <RuleSource>[], required this.user});

  @override
  List<Object> get props => [nextSources, user];
}

class PreviousSelectionsLoaded extends SelectionsState {
  final List<RuleSource> previousSources;
  final String user;
  const PreviousSelectionsLoaded(
      {this.previousSources = const <RuleSource>[], required this.user});
  @override
  List<Object> get props => [previousSources, user];
}

class SelectionActivated extends SelectionsState {
  final RuleSource currentSource;
  final List<RuleSource> currentSources;
  final String user;
  const SelectionActivated(this.currentSource, this.currentSources, this.user);

  @override
  List<Object> get props => [currentSource, currentSources, user];
}

class SelectionDeactivated extends SelectionsState {
  final RuleSource currentSource;
  final List<RuleSource> currentSources;
  final String user;
  const SelectionDeactivated(
      this.currentSource, this.currentSources, this.user);

  @override
  List<Object> get props => [currentSource, currentSources, user];
}

class OutputDisplayed extends SelectionsState {
  final List<Rule> rules;
  const OutputDisplayed(this.rules);
  @override
  List<Object> get props => [rules];
}
