import 'package:equatable/equatable.dart';

import 'entities/ruleSource.dart';

class GenerateButtonStyler extends Equatable {
  List<RuleSource> styleButton(currentSource, currentSources) {
    for (var j = 0; j < currentSources.length; j++) {
      if (currentSources[j] == currentSource) {
        currentSources[j].updateActive();
      }
    }
    return currentSources;
  }

  @override
  List<Object?> get props => [];
}
