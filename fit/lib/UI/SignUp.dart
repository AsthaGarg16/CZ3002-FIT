import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './Login.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget newScreen;
  final Widget oldScreen;

  CustomPageRoute({required this.oldScreen, required this.newScreen}) : super(pageBuilder: (context, animation, secondaryAnimation) => newScreen,);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
      return Stack(
          children: <Widget>[
            //slide new screen in
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),

            //slide old screen out
            SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(-1, 0),
                ).animate(animation),
                child: oldScreen
            )
          ]
      );
    }
}

//Using preference page as a separate class instead of inlcuding it in the sign up page class in
//case we want to use this page in the app settings later
class PreferencePage extends StatefulWidget{
  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage>{
  String numCompartments = 'One';

  Widget _buildPreferenceList(){
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          title: Text('Compartments',  style: Theme.of(context).textTheme.bodyText1),
          trailing: DropdownButton<String>(
            value: numCompartments,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                numCompartments = newValue!;
              });
            },
            items: <String>['One', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ),
        Divider(),
      ]
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        //hero widget to preserve app bar between the two sign up pages. Make sure tag of old page and new page within the hero constructor is the same
          child: Hero(
            tag: "SignUpAppBar",
            child: AppBar(
                title: Text("Sign Up", style: Theme.of(context).textTheme.subtitle1),
                systemOverlayStyle: SystemUiOverlayStyle.light,
                titleSpacing: 0,
                leading: IconButton(
                    onPressed: (){Navigator.pop(context);},
                    icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white
                    )
                )
            ),
          ),
          preferredSize: new AppBar().preferredSize,
      ),

      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Select your preferences", style: Theme.of(context).textTheme.bodyText1,),

                const SizedBox(height: 20,),

                SizedBox(
                  child:_buildPreferenceList(),
                  height: 400,
                ),

                const SizedBox(height: 20,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.only(top: 3,left: 3),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height:60,
                      onPressed: (){
                      },
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      child: Text("Create Account", style: Theme.of(context).textTheme.subtitle1,),
                    ),
                  ),
                ),
              ]
          )
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
      appBar: PreferredSize(
        child: Hero(
          tag: "SignUpAppBar",
          child: AppBar(
              title: Text("Sign Up", style: Theme.of(context).textTheme.subtitle1),
              systemOverlayStyle: SystemUiOverlayStyle.light,
              titleSpacing: 0,
              leading: IconButton(
                  onPressed: (){Navigator.pop(context);},
                  icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white
                  )
              )
          ),
        ),
        preferredSize: new AppBar().preferredSize,
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
                              //To make sliding transision we use custom page route which extends material page route
                                CustomPageRoute(
                                  oldScreen: this,
                                  newScreen: PreferencePage(),
                                )
                            );
                          },
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          child: Text("Next", style: Theme.of(context).textTheme.subtitle1,),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20,),

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