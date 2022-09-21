import 'package:equatable/equatable.dart';

// Entity of rule source.
// Contains the data needed for selecting, organizing, and displaying
// rule sources. These are represented by the buttons/ user selections.
// Each source may have multiple rules associated with it.
class RuleSource extends Equatable {
  String sourceName;
  String sourceFaction;
  String sourceType;
  String nextSourceType;
  bool sourceActive;
  String sourceId;
  RuleSource({
    this.sourceName = '',
    this.sourceFaction = '',
    this.sourceType = '',
    this.nextSourceType = '',
    this.sourceActive = false,
    this.sourceId = '',
  });

  updateActive() {
    if (sourceActive == false) {
      sourceActive = true;
    } else {
      sourceActive = false;
    }
  }

  setSourceId(sourceIdToSet) {
    sourceId = sourceIdToSet;
  }

  @override
  List<Object> get props => [
        sourceName,
        sourceFaction,
        sourceType,
        nextSourceType,
        sourceActive,
        sourceId,
      ];
}
