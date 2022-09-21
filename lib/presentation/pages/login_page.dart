import 'package:aos/presentation/pages/selections_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login/login_bloc.dart';

// AOSLoginPage takes in the user's credentials to sign in to
// firebase firestore and the app.
// It is displayed after the welcome page upon selection of login button.
class AOSLoginPage extends StatelessWidget {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to AoS Playmat Builder'),
      ),
      body: Column(
        children: [
          const Text(
            'Enter your information to log in.',
            style: TextStyle(
              color: Colors.red,
              fontSize: 40.0,
            ),
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value) {
              email = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value) {
              password = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          ElevatedButton(
            child: const Text('login'),
            onPressed: () async {
              context
                  .read<LoginBloc>()
                  .add(Login(email: email, password: password));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectionsPage([], email)));
            },
          ),
        ],
      ),
    );
  }
}
