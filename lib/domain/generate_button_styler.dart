import 'package:equatable/equatable.dart';

import 'entities/source.dart';

class GenerateButtonStyler extends Equatable {
  styleButton(currentSource, currentSources) {
    for (var j = 0; j < currentSources.length; j++) {
      if (currentSources[j] == currentSource) {
        print(currentSources[j].sourceActive);
        currentSources[j].updateActive();
        print(currentSources[j].sourceActive);
      }
    }
    return currentSources;
  }

  passSources(currentSources) {
    return currentSources;
  }

  @override
  List<Object?> get props => [];
}
