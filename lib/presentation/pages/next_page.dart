import 'package:aos/blocs/selections/selections_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/save/save_bloc.dart';
import '../../domain/generate_next_page.dart';

class NextPage extends StatelessWidget {
  var currentSources;
  NextPage(this.currentSources);
  @override
  Widget build(BuildContext context) {
    //   print('we got inside NextPage');
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.white,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select'),
        ),
        body: BlocBuilder<SelectionsBloc, SelectionsState>(
          builder: (context, state) {
            return SizedBox.expand(
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.5,
                alignment: FractionalOffset.center,
                child: Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: currentSources.length,
                    itemBuilder: (context, index) {
                      return TextButton(
                        child: Text(
                          currentSources[index].sourceName,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          context
                              .read<SaveBloc>()
                              .add(SaveToDb(currentSources[index]));
                          context.read<SelectionsBloc>().add(LoadNextSelections(
                              currentSources: [currentSources[index]]));
                          // generateNextPage(buttonsList[index].sourceFaction,
                          //    buttonsList[index].nextSourceType, context);
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
