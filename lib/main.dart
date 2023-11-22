import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDc05cXbtvAS2cDLPUvFEJlgmIyEc91zYM",
          appId: "1:451952942569:android:50c0f6ead3c6cbb1bcff78",
          messagingSenderId: "",
          projectId: "e-dervices-fyp"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: Scaffold(),
    );
  }
}
