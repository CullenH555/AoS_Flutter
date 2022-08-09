import 'package:flutter/material.dart';
import '../../domain/generate_next_page.dart';

class AOSHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: SizedBox.expand(
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.5,
          alignment: FractionalOffset.center,
          child: Column(
            children: [
              TextButton(
                child: Text(
                  'Sylvaneth',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  generateNextPage('sylvaneth', 'subfaction', context);
                },
              ),
              TextButton(
                child: Text(
                  'Kharadron',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  generateNextPage('kharadron', 'subfaction', context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
