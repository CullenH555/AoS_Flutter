import 'package:aos/presentation/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

// AOSWelcomePage gives the user an option to log in if they have an account
// or to register their credentials.
// It navigates to the corresponding page.
class AOSWelcomePage extends StatelessWidget {
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
      // backgroundColor: Colors.grey.shade800,
      // backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 15.0,
            ),
            child: Text(
              'If you have an account, log in. Otherwise create an account.',
              style: TextStyle(
                //  color: Colors.orangeAccent,
                color: Colors.blueGrey.shade200,
                fontSize: 27.0,
                height: 1.5,
                letterSpacing: .5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 75, 0, 20),
            child: ElevatedButton(
              child: const Text('login'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AOSLoginPage()));
              },
            ),
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
