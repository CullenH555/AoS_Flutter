// This page remains as a reminder of the intermediate format
// of the main functionality before serious refactoring.
// The refactoring took reused code and made it into reusable widget
// Furthermore, state management was streamlined.

/*

import 'dart:ffi';

import 'package:aos/blocs/selections/selections_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/generate_next_page.dart';

class NextPage extends StatelessWidget {
  var currentSources;
  NextPage(this.currentSources);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionsBloc, SelectionsState>(
        builder: (context, state) {
      if (state is NextSelectionsLoaded) {
        var category = currentSources[0].sourceType;
        print("state is NextSelectionsLoaded!");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Choose $category',
                style: TextStyle(
                  fontSize: 40.0,
                  backgroundColor: Colors.redAccent,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: SizedBox.expand(
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
                              color: currentSources[index].sourceActive == true
                                  ? Colors.blue
                                  : Colors.red,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            print("we just clicked: ");
                            //     context
                            //        .read<SaveBloc>()
                            //       .add(SaveToDb(state.initSources[index]));
                            //  context
                            //     .read<SaveBloc>()
                            //     .add(SaveToLocal(state.initSources[index]));
                            if (currentSources[index].sourceActive == false) {
                              print("we got inside add event to bloc");
                              context
                                  .read<SelectionsBloc>()
                                  .add(ActivateSelection(
                                    currentSource: currentSources[index],
                                    currentSources: currentSources,
                                  ));
                            } else if (currentSources[index].sourceActive ==
                                true) {
                              context
                                  .read<SelectionsBloc>()
                                  .add(DeactivateSelection(
                                    currentSources[index],
                                    currentSources,
                                  ));
                            }
                            //  generateNextPage(buttonsList[index].sourceFaction,
                            //  buttonsList[index].nextSourceType, context);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
      if (state is SelectionActivated) {
        var category = currentSources[0].sourceType;
        print("we got inside state SelectionActivated");
        return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            child: Text(
              'Choose $category',
              style: TextStyle(
                fontSize: 40.0,
                backgroundColor: Colors.redAccent,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: SizedBox.expand(
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
                              color: currentSources[index].sourceActive == true
                                  ? Colors.blue
                                  : Colors.red,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            print('we pressed the button');
                            print(state.currentSources[index].sourceActive);
                            if (state.currentSources[index].sourceActive ==
                                true) {
                              context
                                  .read<SelectionsBloc>()
                                  .add(DeactivateSelection(
                                    state.currentSources[index],
                                    state.currentSources,
                                  ));
                            } else {
                              context
                                  .read<SelectionsBloc>()
                                  .add(ActivateSelection(
                                    currentSource: state.currentSources[index],
                                    currentSources: state.currentSources,
                                  ));
                            }
                          },
                        );
                      }),
                ),
              ),
            ),
          ),
        ]);
      }
      if (state is SelectionDeactivated) {
        var category = currentSources[0].sourceType;
        print("we got inside state SelectionDeactivated");
        return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            child: Text(
              'Choose $category',
              style: TextStyle(
                fontSize: 40.0,
                backgroundColor: Colors.redAccent,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: SizedBox.expand(
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.5,
                alignment: FractionalOffset.center,
                child: Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: currentSources.length,
                      itemBuilder: (context, index) {
                        print("just before buttonrender: ");
                        return TextButton(
                          child: Text(
                            currentSources[index].sourceName,
                            style: TextStyle(
                              color: currentSources[index].sourceActive == true
                                  ? Colors.blue
                                  : Colors.red,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            print('we pressed the button');
                            print(state.currentSources[index].sourceActive);
                            if (state.currentSources[index].sourceActive ==
                                true) {
                              context
                                  .read<SelectionsBloc>()
                                  .add(DeactivateSelection(
                                    state.currentSources[index],
                                    state.currentSources,
                                  ));
                            } else {
                              context
                                  .read<SelectionsBloc>()
                                  .add(ActivateSelection(
                                    currentSource: state.currentSources[index],
                                    currentSources: state.currentSources,
                                  ));
                            }
                          },
                        );
                      }),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              context
                  .read<SelectionsBloc>()
                  .add(LoadNextSelections(currentSources: currentSources));
            },
          ),
        ]);
      }
      if (state is NextSelectionsLoaded) {
        return NextPage(state.nextSources);
      } else {
        return Text('Error');
      }
    });
    //    floatingActionButton: BlocBuilder<SelectionsBloc, SelectionsState>(
    //       builder: (context, state) {
    //     return FloatingActionButton(
    //       child: Icon(Icons.add),
    //       onPressed: () {
    //   context
    //      .read<SelectionsBloc>()
    //     .add(LoadNextSelections(currentSources: state.nextSources));
    //    },
    //   );
    //   }),
  }
}

 */
