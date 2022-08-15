import 'package:equatable/equatable.dart';

import 'entities/source.dart';

class GenerateButtonStyler extends Equatable {
  GenerateButtonStyler(
      {this.currentSource = const Source(),
      this.currentSources = const <Source>[],
      this.active = const <bool>[]});
  final currentSource;
  List<Source> currentSources;
  List<bool> active;

  styleButton(currentSource, currentSources, active) {
    for (var j = 0; j < currentSources.length; j++) {
      if (currentSources[j] == currentSource) {
        if (active[j] == false) {
          active[j] = true;
        } else {
          active[j] = false;
        }
      }
    }
    return active;
  }

  passSources(currentSources) {
    return currentSources;
  }

  @override
  List<Object?> get props => [currentSources, active];
}
