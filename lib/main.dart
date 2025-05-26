import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/controller/productcont.dart';
import 'package:task/view/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Productcont(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Homescreen(),
      ),
    );
  }
}
