import 'package:aos/blocs/selections/selections_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login/login_bloc.dart';
import '../../domain/entities/rule_source.dart';
import '../widgets/selections.dart';
import 'display_page.dart';

// SelectionsPage is shown after the user successfully logs in.
// It displays the selection options in the form of toggleable buttons.
// Activating/deactivating buttons sets/unsets the corresponding data
// to the user's save collection in the db.
// It allows for forward and back navigation among the selection categories.
// Each category will display its corresponding option buttons.
// It is the main page for the app.
class SelectionsPage extends StatelessWidget {
  static const String id = 'first_page';
  SelectionsPage(this.currentSources, this.user);
  List<RuleSource> currentSources;
  final String user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: null,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              context.read<LoginBloc>().add(Logout());
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          'AoS Playmat Builder',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: BlocBuilder<SelectionsBloc, SelectionsState>(
          builder: (context, state) {
        if (state is InitialSelectionsLoaded) {
          //      print("we got inside InitialSelectionsLoaded");
          return Selections(state.initialSources, user);
        }
        if (state is SelectionActivated) {
          //      print("we got inside state SelectionActivated in first page");
          return Selections(state.currentSources, user);
        }
        if (state is SelectionDeactivated) {
          //       print("we got inside state SelectionDeactivated");
          return Selections(state.currentSources, user);
        }
        if (state is NextSelectionsLoaded) {
          //       print("we got inside state NextSelectionsLoaded");
          return Selections(state.nextSources, user);
        }
        if (state is PreviousSelectionsLoaded) {
          //      print('we got inside PreviousSelectionsLoaded');
          return Selections(state.previousSources, user);
        }
        if (state is OutputDisplayed) {
          //      print('state is OutputDisplayed');
          return DisplayPage(state.rules, user);
        } else if (state is SelectionsInitial) {
          //     print('state is SelectionsInitial and we try component');
          List<RuleSource> initSources = state.sources;
          return Selections(initSources, user);
        } else {
          return const Text('Error');
        }
      }),
    );
  }
}
