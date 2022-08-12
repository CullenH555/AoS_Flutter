import 'package:aos/blocs/selections/selections_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          //  context
                          //     .read<SaveBloc>()
                          //     .add(SaveToLocal(state.initSources[index]));
                          context.read<SelectionsBloc>().add(LoadNextSelections(
                              currentSources: [state.initSources[index]]));
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
          if (state is NextSelectionsLoaded) {
            return NextPage(state.nextSources);
          }
          return Text('Error');
        }, // builder
      ),
    );
  }
}
