import 'package:aos/presentation/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class AOSWelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to AoS Playmat Builder'),
      ),
      body: Column(
        children: [
          const Text(
            'If you have an account, log in. Otherwise create an account.',
            style: TextStyle(
              color: Colors.red,
              fontSize: 40.0,
            ),
          ),
          ElevatedButton(
            child: const Text('login'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AOSLoginPage()));
            },
          ),
          ElevatedButton(
            child: const Text('create account'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AOSRegistrationPage()));
            },
          ),
        ],
      ),
    );
  }
}
