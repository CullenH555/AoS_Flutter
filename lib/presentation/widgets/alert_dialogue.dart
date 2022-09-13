import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/selections/selections_bloc.dart';

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
