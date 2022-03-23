import 'package:flutter/material.dart';
import './Login.dart';
import './SignUp.dart';
import './RecipeCard.dart';
import 'RecipePage.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: Theme.of(context).textTheme.subtitle1),
        centerTitle: true,
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/food.png')),
              ),
            ),

            const SizedBox(
              height: 50,
            ),

            Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Login()));
                  },
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )),

            //Gap between login and sign up button
            const SizedBox(
              height: 30,
            ),

            Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => SignupPage()));
                  },
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
