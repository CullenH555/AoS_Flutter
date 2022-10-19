import 'package:aos_playmat_builder_flutter/blocs/selections/selections_bloc.dart';
import 'package:aos_playmat_builder_flutter/presentation/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aos_playmat_builder_flutter/blocs/login/login_bloc.dart';
import 'package:aos_playmat_builder_flutter/injection_container.dart' as di;
import 'package:aos_playmat_builder_flutter/injection_container.dart';

void main() async {
  di.init();
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
          create: (context) => sl<SelectionsBloc>(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'AOS Flutter',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          backgroundColor: Colors.white,
          textTheme: TextTheme(
            labelSmall: TextStyle(
              color: Colors.blueGrey.shade200,
              fontSize: 20.0,
              letterSpacing: 1.5,
            ),
            headlineMedium: TextStyle(
              color: Colors.blueGrey.shade200,
              fontSize: 40.0,
            ),
            bodySmall: TextStyle(
              color: Colors.blueGrey.shade200,
              height: 1.5,
              fontSize: 20.0,
              letterSpacing: 1,
            ),
            headlineSmall: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            labelMedium: const TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: Colors.blueGrey.shade200,
              fontSize: 20.0,
              letterSpacing: 1,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
        home: AOSWelcomePage(),
      ),
    );
  }
}
