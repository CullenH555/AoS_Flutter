import 'package:equatable/equatable.dart';

import 'entities/ruleSource.dart';

class GenerateButtonStyler extends Equatable {
  styleButton(currentSource, currentSources) {
    for (var j = 0; j < currentSources.length; j++) {
      if (currentSources[j] == currentSource) {
        print('Inside Style button, currentSource Activity is:');
        print(currentSources[j].sourceActive);
        currentSources[j].updateActive();
        print('Inside Style button, after update currentSource Activity is:');
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
