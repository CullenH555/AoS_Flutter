import 'package:flutter/material.dart';
import '../../domain/generate_next_page.dart';

class NextPage extends StatelessWidget {
  var buttonsList;
  NextPage(this.buttonsList);
  @override
  Widget build(BuildContext context) {
    print('we got inside NextPage');
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.white,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select'),
        ),
        body: SizedBox.expand(
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.5,
            alignment: FractionalOffset.center,
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: buttonsList.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    child: Text(
                      buttonsList[index].sourceName,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      generateNextPage(buttonsList[index].sourceFaction,
                          buttonsList[index].nextSourceType, context);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
