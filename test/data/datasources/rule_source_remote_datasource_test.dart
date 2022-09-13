import 'package:aos/data/datasources/rule_source_remote_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  RuleSourceRemoteDatasource datasource;
  MockFirebaseFirestore mockFirebaseFirestore;

  setUp(() {
    mockFirebaseFirestore = MockFirebaseFirestore();
    datasource = RuleSourceRemoteDatasourceImp(client: mockFirebaseFirestore);
  });
  group('getRuleSourcesFromDb', () {
    mockFirebaseFirestore = MockFirebaseFirestore();
    datasource = RuleSourceRemoteDatasourceImp(client: mockFirebaseFirestore);
    final tUser = 'testUser';
    test(
      '''should perform a GET request to the firestore instance 
      with testUser being the collection name''',
      () async {
        // arrange
        // This should simulate a call to the firestore and return the data
        // firestore returns a custom type QuerySnapshot, so how to implement the test?
        // Should the forEach step happen outside the datasource? For example in the model?
        when(
          mockFirebaseFirestore
              .collection(tUser)
              .get()
              .then((QuerySnapshot snapshot) {
            snapshot.docs.forEach(
              // add data to the list
              (f) => sourceItems.add(f.data()),
            );
          }),
        ).thenReturn('yay');
        //act

        //assert
      },
    );
  });
}
