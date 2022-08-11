part of 'save_bloc.dart';

abstract class SaveEvent extends Equatable {
  const SaveEvent();
}

class SaveToLocal extends SaveEvent {
  const SaveToLocal(this.currentSource);
  final Source currentSource;

  @override
  List<Object?> get props => [currentSource];
}

class DeleteFromLocal extends SaveEvent {
  const DeleteFromLocal({this.currentSource = const Source()});
  final Source currentSource;

  @override
  List<Object> get props => [currentSource];
}
