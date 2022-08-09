import 'package:flutter/material.dart';
import '../data/model/source.dart';
import '../data/repository.dart';
import '../presentation/pages/next_page.dart';

generateNextPage(sourceFaction, nextSourceType, context) {
  var buttonsList = [];
  Repo repo = RepoImp();
  List<Source> data = repo.getOrganizedDataFromRepo();
  for (var i = 0; i < data.length; i++) {
    if (data[i].sourceType == nextSourceType &&
        data[i].sourceFaction == sourceFaction) {
      buttonsList.add(data[i]);
    }
  }
  print(buttonsList);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NextPage(buttonsList)),
  );
}
