import 'package:flutter/material.dart';
import 'package:redcar/views/pages/main_page.dart';


void main() => runApp(MvvmApp());

class MvvmApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'RedCar',
      theme: new ThemeData(
        primaryColor: Color(0xff00c9ff), 
        primaryColorLight: Colors.grey,
        primaryColorDark: Colors.green,
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}