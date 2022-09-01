import 'package:equatable/equatable.dart';

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

  get ruleName {
    return ruleName;
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
