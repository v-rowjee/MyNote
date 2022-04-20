import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynote/pages/home_page.dart';

void main() {
  //appbar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.grey[900],
  ));
  //run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.dark
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
