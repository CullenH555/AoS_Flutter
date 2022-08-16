import 'package:aos/blocs/selections/selections_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login/login_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/source.dart';
import '../../domain/generate_next_page.dart';
import 'next_page.dart';

class AOSFirstPage extends StatelessWidget {
  static const String id = 'first_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              context.read<LoginBloc>().add(Logout());
              Navigator.pop(context);
            },
          ),
        ],
        title: Text('AoS Playmat Builder'),
      ),
      body: BlocBuilder<SelectionsBloc, SelectionsState>(
          builder: (context, state) {
        if (state is SelectionsInitial) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Choose faction',
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
                          itemCount: state.initSources.length,
                          itemBuilder: (context, index) {
                            return TextButton(
                              child: Text(
                                state.initSources[index].sourceName,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                //     context
                                //        .read<SaveBloc>()
                                //       .add(SaveToDb(state.initSources[index]));
                                //  context
                                //     .read<SaveBloc>()
                                //     .add(SaveToLocal(state.initSources[index]));
                                context
                                    .read<SelectionsBloc>()
                                    .add(ActivateSelection(
                                      currentSource: state.initSources[index],
                                      currentSources: state.initSources,
                                    ));
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
              ]);
        }
        if (state is SelectionActivated) {
          var category = state.currentSources[0].sourceType;
          print("we got inside state SelectionActivated in first page");
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
                            itemCount: state.currentSources.length,
                            itemBuilder: (context, index) {
                              return TextButton(
                                child: Text(
                                  state.currentSources[index].sourceName,
                                  style: TextStyle(
                                    color: state.currentSources[index]
                                                .sourceActive ==
                                            true
                                        ? Colors.blue
                                        : Colors.red,
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  print('we pressed the button');
                                  print(
                                      state.currentSources[index].sourceActive);
                                  if (state
                                          .currentSources[index].sourceActive ==
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
                                          currentSource:
                                              state.currentSources[index],
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
                    print("we used this");
                    if (state.currentSources[0].sourceType == 'artifact') {
                      context
                          .read<SelectionsBloc>()
                          .add(DisplayOutput(state.currentSources));
                    }
                    context.read<SelectionsBloc>().add(LoadNextSelections(
                        currentSources: state.currentSources));
                  },
                ),
              ]);
        }
        if (state is SelectionDeactivated) {
          var category = state.currentSources[0].sourceType;
          print("we got inside state SelectionDeactivated");
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
                            itemCount: state.currentSources.length,
                            itemBuilder: (context, index) {
                              return TextButton(
                                child: Text(
                                  state.currentSources[index].sourceName,
                                  style: TextStyle(
                                    color: state.currentSources[index]
                                                .sourceActive ==
                                            true
                                        ? Colors.blue
                                        : Colors.red,
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  print('we pressed the button');
                                  print(
                                      state.currentSources[index].sourceActive);
                                  if (state
                                          .currentSources[index].sourceActive ==
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
                                          currentSource:
                                              state.currentSources[index],
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
                    print("we used this");
                    if (state.currentSources[0].sourceType == 'artifact') {
                      context
                          .read<SelectionsBloc>()
                          .add(DisplayOutput(state.currentSources));
                    }
                    context.read<SelectionsBloc>().add(LoadNextSelections(
                        currentSources: state.currentSources));
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
    );
  }
}
// TODO finish view generator.
// TODO pass same buttonList around while toggling.
// TODO only update to generateNextPage nextSources when hitting navigate button.
