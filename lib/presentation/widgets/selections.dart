import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/selections/selections_bloc.dart';
import '../../domain/entities/rule_source.dart';

class Selections extends StatelessWidget {
  Selections(this.sources);
  List<RuleSource> sources;
  @override
  Widget build(BuildContext context) {
    String category = sources.isNotEmpty
        ? sources[0].sourceType
        : 'Make sure to choose a faction.';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Choose $category:',
          style: const TextStyle(
            fontSize: 40.0,
            backgroundColor: Colors.redAccent,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: SizedBox.expand(
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 0.5,
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
                            ? Colors.blue
                            : Colors.red,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      context.read<SelectionsBloc>().add(ActivateSelection(
                            currentSource: sources[index],
                            currentSources: sources,
                          ));
                    },
                  );
                },
              ),
            ),
          ),
        ),
        FloatingActionButton(
          heroTag: null,
          child: const Icon(Icons.add),
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
          heroTag: null,
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            if (sources.isEmpty) {
              print('We try to go back to initial page');
              context.read<SelectionsBloc>().add(LoadInitialSelections());
            } else {
              context.read<SelectionsBloc>().add(LoadNextSelections(
                  currentSources: sources, direction: 'previous'));
            }
          },
        ),
        Container(
          height: 50.0,
        ),
      ],
    );
  }
}
