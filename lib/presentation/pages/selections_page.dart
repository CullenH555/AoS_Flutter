import 'package:aos/blocs/selections/selections_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login/login_bloc.dart';
import '../../domain/entities/rule_source.dart';
import '../widgets/selections.dart';
import 'display_page.dart';

class SelectionsPage extends StatelessWidget {
  static const String id = 'first_page';
  SelectionsPage(this.currentSources);
  List<RuleSource> currentSources;
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
        if (state is InitialSelectionsLoaded) {
          print("we got inside InitialSelectionsLoaded");
          return Selections(state.initialSources);
        }
        if (state is SelectionActivated) {
          print("we got inside state SelectionActivated in first page");
          return Selections(state.currentSources);
        }
        if (state is SelectionDeactivated) {
          print("we got inside state SelectionDeactivated");
          return Selections(state.currentSources);
        }
        if (state is NextSelectionsLoaded) {
          print("we got inside state NextSelectionsLoaded");
          return Selections(state.nextSources);
        }
        if (state is PreviousSelectionsLoaded) {
          print('we got inside PreviousSelectionsLoaded');
          return Selections(state.previousSources);
        }
        if (state is OutputDisplayed) {
          print('state is OutputDisplayed');
          return DisplayPage(state.rules);
        } else if (state is SelectionsInitial) {
          print('state is SelectionsInitial and we try component');
          var initSources = state.sources;
          return Selections(initSources);
        } else {
          return Text('Error');
        }
      }),
    );
  }
}
