import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/selections/selections_bloc.dart';
import '../../domain/entities/ruleSource.dart';

class Selections extends StatelessWidget {
  Selections(this.sources);
  List<RuleSource> sources;
  @override
  Widget build(BuildContext context) {
    String category = sources[0].sourceType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(
            'Choose $category:',
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
                  itemCount: sources.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      child: Text(
                        sources[index].sourceName,
                        style: TextStyle(
                          color: sources[index].sourceActive == true
                              ? Colors.blue
                              : Colors.red,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // TODO refactor the onPressed logic out of the UI and into the domain
                      // Basically, move this activity check into a class method.
                      onPressed: () {
                        if (sources[index].sourceActive == true) {
                          context
                              .read<SelectionsBloc>()
                              .add(DeactivateSelection(
                                sources[index],
                                sources,
                              ));
                        } else {
                          context.read<SelectionsBloc>().add(ActivateSelection(
                                currentSource: sources[index],
                                currentSources: sources,
                              ));
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //  print(sources[0].sourceType);
            if (sources[0].sourceType == 'battalion') {
              context.read<SelectionsBloc>().add(DisplayOutput());
            } else {
              // Comment out below for initRulesToDb
              context
                  .read<SelectionsBloc>()
                  .add(LoadNextSelections(currentSources: sources));
              // Uncomment below for initRulesToDb
              //   context
              //      .read<SelectionsBloc>()
              //      .add(ActivateSelection(currentSources: sources));
            }
          },
        ),
        Container(
          height: 100,
        ),
        IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {
            context
                .read<SelectionsBloc>()
                .add(LoadPreviousSelections(currentSources: sources));
          },
        ),
      ],
    );
  }
}
