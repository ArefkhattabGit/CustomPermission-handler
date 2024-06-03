import 'package:flutter/material.dart';
import 'package:untitled2/helper/permission_helper.dart';
import 'package:untitled2/module/home/home_screen.dart';

void main() {

   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'permission handler example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomeScreen(),
    );
  }
}
