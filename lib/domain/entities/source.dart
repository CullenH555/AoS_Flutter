import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'rule.dart';

class Source extends Equatable {
  const Source(
      {this.sourceName = '',
      this.sourceFaction = '',
      this.sourceType = '',
      this.nextSourceType = '',
      this.rulesList = const <Rule>[]});
  final String sourceName;
  final String sourceFaction;
  final String sourceType;
  final String nextSourceType;
  final List rulesList;

  @override
  List<Object> get props =>
      [sourceName, sourceFaction, sourceType, nextSourceType, rulesList];
}