import 'package:aos/blocs/selections/selections_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/generate_next_page.dart';

class NextPage extends StatelessWidget {
  var currentSources;
  NextPage(this.currentSources);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              //   context.read<LoginBloc>().add(Logout());
              //   Navigator.pop(context);
            },
          ),
        ],
        title: Text('AoS Playmat Builder'),
      ),
      body: BlocBuilder<SelectionsBloc, SelectionsState>(
          builder: (context, state) {
        if (state is NextSelectionsLoaded) {
          print("state is NextSelectionsLoaded!");
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
                          context.read<SelectionsBloc>().add(ActivateSelection(
                                currentSource: currentSources[index],
                                currentSources: currentSources,
                              ));
                        } else if (currentSources[index].sourceActive == true) {
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
          );
        }
        if (state is SelectionActivated) {
          print("we got inside state SelectionActivated");
          return Column(children: [
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
                                color:
                                    currentSources[index].sourceActive == true
                                        ? Colors.blue
                                        : Colors.red,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              print('we pressed the button');
                              if (currentSources[index].sourceActive == false) {
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
        if (state is SelectionDeactivated) {
          print("we got inside state SelectionDeactivated");
          return Column(children: [
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
                                color:
                                    currentSources[index].sourceActive == true
                                        ? Colors.blue
                                        : Colors.red,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              print('we pressed the button');
                              if (currentSources[index].sourceActive == false) {
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
      }),
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
    );
  }
}
