import 'package:aos/presentation/pages/selections_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login/login_bloc.dart';

class AOSRegistrationPage extends StatelessWidget {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to AoS Playmat Builder'),
      ),
      body: Column(
        children: [
          Container(
            child: Text(
              'Fill out the following to create an account.',
              style: TextStyle(
                color: Colors.red,
                fontSize: 40.0,
              ),
            ),
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value) {
              email = value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value) {
              password = value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('create account'),
              onPressed: () async {
                print(email);
                print(password);
                context
                    .read<LoginBloc>()
                    .add(Register(email: email, password: password));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectionsPage([])));
              },
            ),
          ),
        ],
      ),
    );
  }
}
