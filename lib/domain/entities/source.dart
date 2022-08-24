import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'rule.dart';

class Source extends Equatable {
  String sourceName;
  String sourceFaction;
  String sourceType;
  String nextSourceType;
  bool sourceActive;
  String sourceId;
  Source({
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
