import 'package:flutter/material.dart';
import 'UI/SignUp.dart';
import 'UI/Login.dart';

void main() => runApp(MyApp());



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
          headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2.0),
          headline2: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: 2.0),
          subtitle1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5),
          subtitle2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: 1.5),
          labelMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1.5),
          bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black54),
          bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black54),
        ),
        fontFamily: "mw",
      ),
      home: MyHomePage(title: 'FIT'),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style:Theme.of(context).textTheme.subtitle1),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(height: MediaQuery.of(context).size.height, width: double.infinity, padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/food.png')),),
              ),
              SizedBox(height:50,),

              Container(
                  margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child:MaterialButton(
                    minWidth: double.infinity,
                    height:60,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
                      },
                    color: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    child: Text("Login", style: Theme.of(context).textTheme.subtitle1,
                    ),
                  )
              ),
            //Gap between login and sign up button
            SizedBox(height: 30, ),

            Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height:60,
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => SignupPage()
                      )
                    );
                  },
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  child: Text("Sign Up", style: Theme.of(context).textTheme.subtitle1,),
                )
            ),
          ],
        ),
      )),
    );
  }
}
