import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aos_playmat_builder_flutter/blocs/selections/selections_bloc.dart';

// AlertDialogue provides a popup for the user to advise them that to restart
// their project, they will delete the currently displayed project.
// Confirmation upon navigating away from the final display page .
class AlertDialogue {
  final String user;
  AlertDialogue({required this.user});
  showAlertDialogue(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        context.read<SelectionsBloc>().add(LoadInitialSelections(user: user));
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Are you sure?"),
      content:
          const Text('Your project will be deleted if you click continue.'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return const Text('Error');
  }
}
