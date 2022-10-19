import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aos_playmat_builder_flutter/blocs/selections/selections_bloc.dart';
import 'package:aos_playmat_builder_flutter/domain/entities/rule_source.dart';

class Selections extends StatelessWidget {
  const Selections(this.sources, this.user);
  final List<RuleSource> sources;
  final String user;
  @override
  Widget build(BuildContext context) {
    String category = sources.isNotEmpty
        ? sources[0].sourceType
        : 'a Faction. Go back and make a selection';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 30.0),
          child: Text(
            'Choose $category:',
            style: TextStyle(
              color: Colors.blueGrey.shade200,
              fontSize: 26.0,
              height: 1.5,
              letterSpacing: .5,
            ),
          ),
        ),
        Expanded(
          child: SizedBox.expand(
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: .9,
              alignment: FractionalOffset.center,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: sources.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    child: Text(
                      sources[index].sourceName,
                      style: TextStyle(
                        color: sources[index].sourceActive == true
                            ? Colors.brown
                            : Colors.blueGrey.shade200,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      context.read<SelectionsBloc>().add(ActivateSelection(
                            currentSource: sources[index],
                            currentSources: sources,
                            user: user,
                          ));
                    },
                  );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: FloatingActionButton(
                  heroTag: null,
                  child: const Icon(Icons.arrow_back),
                  onPressed: () {
                    // If user made an error, go back to initial.
                    if (sources.isEmpty) {
                      context
                          .read<SelectionsBloc>()
                          .add(LoadInitialSelections(user: user));
                    } else {
                      context.read<SelectionsBloc>().add(LoadNextSelections(
                            currentSources: sources,
                            direction: 'previous',
                            user: user,
                          ));
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 40.0,
                  ),
                  // Below is a ternary for getting rid of the add button
                  // if the sources are empty. This helps direct the user
                  // to select a faction before continuing.
                  child: sources.isNotEmpty
                      ? FloatingActionButton(
                          heroTag: null,
                          child: const Icon(Icons.add),
                          onPressed: () {
                            //  print(sources[0].sourceType);
                            if (sources[0].sourceType == 'battalion') {
                              context
                                  .read<SelectionsBloc>()
                                  .add(DisplayOutput(user: user));
                            } else {
                              // Comment out below for initRulesToDb
                              context
                                  .read<SelectionsBloc>()
                                  .add(LoadNextSelections(
                                    currentSources: sources,
                                    direction: 'next',
                                    user: user,
                                  ));
                              // Uncomment below for initRulesToDb
                              //   context
                              //      .read<SelectionsBloc>()
                              //      .add(ActivateSelection(currentSources: sources));
                            }
                          },
                        )
                      : null),
            ],
          ),
        ),
      ],
    );
  }
}
