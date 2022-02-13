import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './Login.dart';

class PreferencePage extends StatefulWidget{
  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferences"),
      )
    );
  }
}

class SignupPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sign Up", style: Theme.of(context).textTheme.subtitle1),
        //Not sure if background of app bar should match sign up button
        // backgroundColor: Colors.redAccent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleSpacing: 0,
        leading: IconButton(
            onPressed: () {Navigator.pop(context);},
            icon:Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)
        ),
      ),

      body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text ("Welcome!", style: Theme.of(context).textTheme.subtitle2,),
                        const SizedBox(height: 20,),
                        Text("Create an Account", style: Theme.of(context).textTheme.bodyText1,),
                        SizedBox(height: 30,)
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          makeInput(label: "Email:"),
                          makeInput(label: "Password:",obscureText: true),
                          makeInput(label: "Confirm Pasword:",obscureText: true)
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3,left: 3),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height:60,
                          onPressed: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) => PreferencePage()
                                )
                            );
                          },
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          child: Text("Next", style: Theme.of(context).textTheme.subtitle1,),
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        Text("Login", style: Theme.of(context).textTheme.labelMedium),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }
}