import 'package:flutter/material.dart';
import 'package:link_shortener/locator.dart';
import 'package:link_shortener/router.dart';
import 'package:link_shortener/views/generate.dart';

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Router.onGenerateRoute,
      home: FutureBuilder(
        future: locator.allReady(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GeneratePage();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
