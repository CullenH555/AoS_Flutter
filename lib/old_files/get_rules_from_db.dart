// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GetRulesFromDb extends Equatable {
  GetRulesFromDb();
  Future<List> getRulesFromDb() async {
    List allRulesList = [];
    final _firestore = FirebaseFirestore.instance;
    await _firestore.collection('rules').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((e) {
        allRulesList.add(e.data());
      });
    });
    return allRulesList;
  }

  @override
  List<Object> get props => [];
}
