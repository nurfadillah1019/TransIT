import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Connection Test',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const FirebaseConnectionPage(), // Set the connection test page
    );
  }
}
