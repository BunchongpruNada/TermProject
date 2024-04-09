import 'package:flutter/material.dart';
import 'page/homepage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ND Search News',
      home: HomePage(),
    );
  }
}
