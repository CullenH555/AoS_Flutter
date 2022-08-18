import 'package:aos/blocs/login/login_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/selections/selections_bloc.dart';

class DisplayPage extends StatelessWidget {
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
          if (state is NextSelectionsLoaded) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Text(
                  'Boop',
                );
              },
            );
          } else {
            return Text('error');
          }
        },
      ),
    );
  }
}
