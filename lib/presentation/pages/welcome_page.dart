import 'package:aos/presentation/pages/first_page.dart';
import 'package:aos/presentation/pages/registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class AOSWelcomePage extends StatelessWidget {
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
              'If you have an account, log in. Otherwise create an account.',
              style: TextStyle(
                color: Colors.red,
                fontSize: 40.0,
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('login'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AOSLoginPage()));
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('create account'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AOSRegistrationPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
