import 'package:aos/blocs/selections/selections_bloc.dart';
import 'package:aos/presentation/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/save/save_bloc.dart';
import 'presentation/pages/first_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'AOS Flutter',
        theme: ThemeData(
          primarySwatch: Colors.red,
          backgroundColor: Colors.white,
        ),
        home: AOSWelcomePage(),
      ),
    );
  }
}

// TODO Next step is to add Bloc.
