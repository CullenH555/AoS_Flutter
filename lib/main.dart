import 'package:aos/blocs/selections/selections_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/save/save_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectionsBloc(),
        ),
        BlocProvider(
          create: (context) => SaveBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'AOS Flutter',
        theme: ThemeData(
          primarySwatch: Colors.red,
          backgroundColor: Colors.white,
        ),
        home: AOSHomePage(),
      ),
    );
  }
}

// TODO Next step is to add Bloc.
