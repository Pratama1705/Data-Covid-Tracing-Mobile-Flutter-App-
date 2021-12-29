// @dart=2.9

import 'package:flutter/material.dart';
import 'package:project_flutter/data_total.dart';
// import 'package:project_flutter/detail_provinsi.dart';
// import 'package:project_flutter/fileClassWidgets/card_button.dart';
// import 'package:project_flutter/fileClassWidgets/card_nobutton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataTotal(),
    );
  }
}
