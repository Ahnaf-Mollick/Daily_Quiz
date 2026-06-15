import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.lightBlueAccent),
      ),
      getPages: Routes.routes,
      initialRoute: Routes.QUESTIONSCREEN,
    );
  }
}
