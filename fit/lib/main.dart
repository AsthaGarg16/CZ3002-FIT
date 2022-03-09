import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'UI/EntryPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal[800],
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2.0),
          headline2: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 2.0),
          headline3: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
              letterSpacing: 2.0),
          subtitle1: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5),
          subtitle2: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1.5),
          labelMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1.5),
          bodyText1: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.black87),
          bodyText2: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
        fontFamily: "mw",
      ),
      home: EntryPage(title: 'FIT'),
    );
  }
}
