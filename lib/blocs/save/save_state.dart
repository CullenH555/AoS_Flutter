part of 'save_bloc.dart';

abstract class SaveState extends Equatable {
  const SaveState();

  void getSave() {}
}

class SavedInitial extends SaveState {
  const SavedInitial({this.savedData = const <Source>[]});
  final List<Source> savedData;

  @override
  List<Object> get props => [savedData];

  List<Source> getSave() {
    return savedData;
  }
}

class Saved extends SaveState {
  const Saved({this.savedData = const <Source>[]});

  final List<Source> savedData;

  @override
  List<Object> get props => [savedData];
}

class SavedToDb extends SaveState {
  const SavedToDb({this.savedData = const <Source>[]});

  final List<Source> savedData;

  @override
  List<Object> get props => [savedData];
}
