import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hyojason/ui/loading_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCrhYBZezSDBy2EBhO44BVzS6kn6UP6hEc',
          appId: 'hyojason-eb3cc',
          messagingSenderId: '380523309260',
          projectId: '380523309260'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(),
    );
  }
}
