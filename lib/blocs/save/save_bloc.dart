import 'dart:async';
// A little hack:
// To import/initialize the firestore database, comment out generate_next_save.dart
// and uncmment generate_initial_ruleData.

import 'package:aos/domain/generate_next_save.dart';
// import 'package:aos/domain/generate_initial_ruleData.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/source.dart';

part 'save_event.dart';
part 'save_state.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {
  SaveBloc() : super(SavedInitial()) {
    //  on<SaveToLocal>(_onSaveToDb);
    //   on<DeleteFromLocal>(_onDeleteFromLocal);
    on<SaveToDb>(_onSaveToDb);
  }
  void _onSaveToLocal(SaveToLocal event, Emitter<SaveState> emit) async {
    var save = GenerateNextSave();
    //  print('save initial is: ');
    //   print(save);
    save.generateNextSave(event.currentSource);
    //  var save = await nextSave.generateNextSave(event.currentSource);
    //   print(save);
    //   var newSave = save.add(event.currentSource);
    emit(
      // Emit the new state: save event --> saved state.
      Saved(savedData: []),
    );
  }
}

void _onSaveToDb(SaveToDb event, Emitter<SaveState> emit) {
  try {
    var saver = GenerateNextSave();
    var saveIt = saver.generateNextSave(event.currentSource);
    emit(
      SavedToDb(savedData: saveIt),
    );
  } catch (e) {
    print(e);
  }
}

// void _onDeleteFromLocal(DeleteFromLocal event, Emitter<SaveState> emit) {
//   emit(
// Saved.deleteFromLocal(event.currentSource),
// );
// }
//}
