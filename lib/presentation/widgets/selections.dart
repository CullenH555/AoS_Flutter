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
                      onPressed: () {
                        context.read<SelectionsBloc>().add(ActivateSelection(
                              sources[index],
                              sources,
                            ));
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
              context.read<SelectionsBloc>().add(LoadNextSelections(
                  currentSources: sources, direction: 'next'));
              // Uncomment below for initRulesToDb
              //   context
              //      .read<SelectionsBloc>()
              //      .add(ActivateSelection(currentSources: sources));
            }
          },
        ),
        Container(
          height: 60.0,
        ),
        FloatingActionButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            context.read<SelectionsBloc>().add(LoadNextSelections(
                currentSources: sources, direction: 'previous'));
          },
        ),
        Container(
          height: 50.0,
        ),
      ],
    );
  }
}
