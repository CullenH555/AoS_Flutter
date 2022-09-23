import 'package:aos/presentation/pages/selections_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login/login_bloc.dart';

// AOSRegistrationPage allows the user to enter their email and password
// in order to create an account.
// It navigates to the selections page upon completion and verification.
class AOSRegistrationPage extends StatelessWidget {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Welcome to AoS Playmat Builder',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 0,
            ),
            child: Text(
              'Create an account.',
              style: TextStyle(
                color: Colors.blueGrey.shade200,
                fontSize: 28.0,
                height: 1.5,
                letterSpacing: .5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 15.0,
            ),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
              onChanged: (value) {
                email = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 15.0,
            ),
            child: TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
              onChanged: (value) {
                password = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            height: 50.0,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 240.0),
              child: ElevatedButton(
                child: const Text('create account'),
                onPressed: () async {
                  print(email);
                  print(password);
                  context
                      .read<LoginBloc>()
                      .add(Register(email: email, password: password));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectionsPage([], email),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
