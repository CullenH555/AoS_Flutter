import 'package:equatable/equatable.dart';
import '../entities/rule_source.dart';

// GenButtonStyler changes the activity property of the selected/ deselected
// user selection button. It is essentially a toggle.
// It takes in the selected/deselected source 'currentSource' and the list
// of all currently displayed sources 'currentSources'.
// It returns the list of RuleSource with the updated activity.
// This will cause the buttons to change color.
class GenButtonStyler extends Equatable {
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
