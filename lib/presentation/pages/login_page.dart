import 'package:aos/presentation/pages/first_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AOSLoginPage extends StatelessWidget {
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
              'Enter your information to log in.',
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
              var email = value;
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
              var password = value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
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
        ],
      ),
    );
  }
}
