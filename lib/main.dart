import 'package:firebase_core/firebase_core.dart';
import 'package:first_part_of_app/screens/home_screen.dart';
import 'package:first_part_of_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //it is to remove the debug tage in the right corner
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // home: LoginScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        'HomeScreen': (context) => HomeScreen(),
      },
    );
  }
}
