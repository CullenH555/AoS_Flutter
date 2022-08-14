import 'package:aos/blocs/selections/selections_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login/login_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../blocs/save/save_bloc.dart';
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
          return SizedBox.expand(
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
                        context.read<SelectionsBloc>().add(DeactivateSelection(
                            currentSource: state.initSources[index],
                            currentSources: state.initSources,
                            active: state.initActive));
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
          print(state.currentSource);
          print(state.currentSources);
          print(state.active);
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
                        itemCount: state.currentSources.length,
                        itemBuilder: (context, index) {
                          print("just before buttonrender: ");
                          print(state.active[index]);
                          return TextButton(
                            child: Text(
                              state.currentSources[index].sourceName,
                              style: TextStyle(
                                color: state.active[index] == true
                                    ? Colors.blue
                                    : Colors.red,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              print('we pressed the button');
                              context.read<SelectionsBloc>().add(
                                  DeactivateSelection(
                                      currentSource:
                                          state.currentSources[index],
                                      currentSources: state.currentSources,
                                      active: state.active));
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
                context.read<SelectionsBloc>().add(
                    LoadNextSelections(currentSources: state.currentSources));
              },
            ),
          ]);
        }
        if (state is SelectionDeactivated) {
          print("we got inside state SelectionDeactivated");
          print(state.currentSource);
          print(state.currentSources);
          print(state.active);
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
                        itemCount: state.currentSources.length,
                        itemBuilder: (context, index) {
                          print("just before buttonrender: ");
                          print(state.active[index]);
                          return TextButton(
                            child: Text(
                              state.currentSources[index].sourceName,
                              style: TextStyle(
                                color: state.active[index] == true
                                    ? Colors.blue
                                    : Colors.red,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              print('we pressed the button');
                              context.read<SelectionsBloc>().add(
                                  ActivateSelection(
                                      currentSource:
                                          state.currentSources[index],
                                      currentSources: state.currentSources,
                                      active: state.active));
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
                context.read<SelectionsBloc>().add(
                    LoadNextSelections(currentSources: state.currentSources));
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

// TODO separate out the navigation from the toggle.
// TODO pass same buttonList around while toggling.
// TODO only update to generateNextPage nextSources when hitting navigate button.
