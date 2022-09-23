import 'package:aos/blocs/selections/selections_bloc.dart';
import 'package:aos/presentation/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'package:aos/injection_container.dart' as di;
import 'package:aos/injection_container.dart';

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
            headlineSmall: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: Colors.blueGrey.shade200,
              fontSize: 20.0,
              letterSpacing: 1,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
        home: AOSWelcomePage(),
        //   SelectionsPage(
        //       []), // working on firstPage -- should be: AOSWelcomePage(),
      ),
    );
  }
}
