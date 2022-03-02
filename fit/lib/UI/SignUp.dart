import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit/Controller/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

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

enum Diet { vegan, vegetarian, }

//Using preference page as a separate class instead of inlcuding it in the sign up page class in
//case we want to use this page in the app settings later
class PreferencePage extends StatefulWidget{
  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage>{
  int _numCompartmentsInt = 1;
  bool _dairyFree = false;
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  Diet? _diet = Diet.vegetarian;

  CollectionReference fit = FirebaseFirestore.instance.collection('fit');


  late TextEditingController _compartmentText;

  @override
  void initState() {
    super.initState();
    _compartmentText = TextEditingController(text: _numCompartmentsInt.toString());
  }


  void _setVegan(bool value){
    _vegan = value;
    if(_vegan){
      _setVegetarian(!_vegan);
    }
  }

  void _setVegetarian(bool value){
    _vegetarian = value;
    if(_vegetarian){
      _setVegan(!_vegetarian);
    }
  }

  Widget _fridgePreferenceList(){
    return SafeArea(child: Column(
      children: <Widget>[
        ListTile(
          title: Text("Fridge", style: Theme.of(context).textTheme.headline3),
        ),

        ListTile(
            title: Text('Compartments',  style: Theme.of(context).textTheme.bodyText1),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove, size: 13.0),
                  onPressed: () => setState(() {
                    _numCompartmentsInt = _numCompartmentsInt - 1;
                    _numCompartmentsInt = _numCompartmentsInt.clamp(0, 100);
                    // _compartmentText.clear();
                    _compartmentText.text = _numCompartmentsInt.toString();
                  }),
                ),

                SizedBox(
                  child: TextField(
                    controller: _compartmentText,
                    style: Theme.of(context).textTheme.bodyText1,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                    onChanged: (String value){
                      developer.log(value);
                    },
                  ),
                  width: 25,
                  height: 30,
                ),

                IconButton(
                  icon: Icon(Icons.add, size: 13.0),
                  onPressed: () => setState(() {
                    _numCompartmentsInt = _numCompartmentsInt + 1;
                    _numCompartmentsInt = _numCompartmentsInt.clamp(0, 100);
                    _compartmentText.text = _numCompartmentsInt.toString();
                  }),
                ),
              ]
          ),
        ),

        const Divider(indent: 15.0, endIndent: 15.0, height: 1.0),
      ],
    ));
  }

  Widget _dietPreferenceList(){
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("Diet", style: Theme.of(context).textTheme.headline3),
        ),
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: Padding(
        //     //todo: how to dynamically set padding ?
        //       padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
        //       child: Text("Fridge", style: Theme.of(context).textTheme.headline3)
        //   ),
        // ),

        RadioListTile<Diet>(
          toggleable: true,
          title: Text('Vegetarian', style: Theme.of(context).textTheme.bodyText1,),
          value: Diet.vegetarian,
          groupValue: _diet,
          onChanged: (Diet? value) {
            setState(() {
              _diet = value;
              if(_diet != null){
                _setVegetarian(true);
              }else{
                _setVegetarian(false);
              }
            });
          },
          controlAffinity: ListTileControlAffinity.trailing
        ),

        const Divider(indent: 15.0, endIndent: 15.0, height: 1.0),

        RadioListTile<Diet>(
          toggleable: true,
          title: Text('Vegan', style: Theme.of(context).textTheme.bodyText1,),
          value: Diet.vegan,
          groupValue: _diet,
          onChanged: (Diet? value) {
            setState(() {
              _diet = value;
              if(_diet != null){
                _setVegan(true);
              }else{
                _setVegan(false);
              }
            });
          },
          controlAffinity: ListTileControlAffinity.trailing
        ),

        const Divider(indent: 15.0, endIndent: 15.0, height: 1.0),

        ListTile(
          title: Text("Allergens", style: Theme.of(context).textTheme.headline3),
        ),

        CheckboxListTile(
          title: Text('Gluten Free', style: Theme.of(context).textTheme.bodyText1),
          value: _glutenFree,
          onChanged: (bool? value) {
            setState(() {
              _glutenFree = !_glutenFree;
              // developer.log(_glutenFree.toString());
            });
          },
        ),

        const Divider(indent: 15.0, endIndent: 15.0, height: 1.0),

        CheckboxListTile(
          title: Text('Dairy Free', style: Theme.of(context).textTheme.bodyText1),
          value: _dairyFree,
          onChanged: (bool? value) {
            setState(() {
              _dairyFree = !_dairyFree;
              // developer.log(_glutenFree.toString());
            });
          },
        ),

        const Divider(indent: 15.0, endIndent: 15.0, height: 1.0),
      ],
    );
  }

  Widget _buildPreferenceList(){
    return ListView(
      // padding: EdgeInsets.symmetric(horizontal: 5.0),
      // physics: NeverScrollableScrollPhysics(),
      children: [
        _fridgePreferenceList(),
        SizedBox(height: 20.0),
        _dietPreferenceList(),
      ]
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          padding: const EdgeInsets.symmetric(horizontal: 6),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Select your preferences", style: Theme.of(context).textTheme.bodyText2,),

                const SizedBox(height: 20,),

                //todo: how to place preferencelist as a child without using a fixed height?
                SizedBox(
                  child:_buildPreferenceList(),
                  height: 450,
                ),
                
                const SizedBox(height: 20,),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height:60,
                    onPressed: () async {
                      await fit.add({'Email': "dummyname@email.com" , 'Vegan':_vegan,'Vegetarian':_vegetarian, 'dairyFree': _dairyFree,
                      'fridgeDetails': _numCompartmentsInt, 'glutenFree': _glutenFree}).then((value) => print("User Details Added"));
                    },
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    child: Text("Create Account", style: Theme.of(context).textTheme.subtitle1,),
                  ),
                ),
              ]
          )
      )
    );
  }
}

class SignupPage extends StatefulWidget{
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = '';
  static String email = '';
  String password = '';
  String confirmPassword = '';
  AuthService _auth=new AuthService();


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
            child: Form(
              key: _formKey,
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
                          Text("Create an Account", style: Theme.of(context).textTheme.bodyText2,),
                          SizedBox(height: 30,)
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Name",
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: (Colors.grey[400])!,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: (Colors.grey[400])!)),
                                  ),
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1,

                                  validator: (String? value) {
                                    if (value != null && value.isEmpty) {
                                      return "Please enter your name";
                                    }

                                    return null;
                                  },
                                  onChanged: (val) {
                                    setState(() => name = val);
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Email: ",
                                      style: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: (Colors.grey[400])!,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: (Colors.grey[400])!)),
                                      ),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1,
                                      validator: (String? value) {
                                        if (value != null && value.isEmpty) {
                                          return "Please enter email";
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() => email = val);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Password: ",
                                      style: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: (Colors.grey[400])!,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: (Colors.grey[400])!)),
                                      ),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1,

                                      validator: (String? value) {
                                        if (value != null && value.isEmpty) {
                                          return "Please enter a password";
                                        }
                                        if (value != null && value.length<6) {
                                          return "Enter a password 6+ chars long";
                                        }

                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() => password = val);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Password: ",
                                      style: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: (Colors.grey[400])!,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: (Colors.grey[400])!)),
                                      ),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1,

                                      validator: (String? value) {
                                        if (value != null && value.isEmpty) {
                                          return "Please confirm your password";
                                        }
                                        if (value != null && value != password) {
                                          return "Passwords do not match";
                                        }

                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() => confirmPassword = val);
                                        print(confirmPassword);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              ],
                            ),

                            // makeInput(label: "Name"),
                            // makeInput(label: "Email"),
                            // makeInput(label: "Password",obscureText: true),
                            // makeInput(label: "Confirm Pasword",obscureText: true)
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height:60,
                          onPressed: ()async{
                            print(name);
                            print(email);
                            print(password);
                            print(confirmPassword);
                            if(_formKey.currentState!.validate()) {

                              await _auth
                                  .registerWithEmailAndPassword(
                                    email, password).then((signupSuccess)=>{
                                      if(signupSuccess)
                                        {
                                        Navigator.of(context).push(
                                        //To make sliding transision we use custom page route which extends material page route
                                        CustomPageRoute(
                                        oldScreen: this.widget,
                                        newScreen: PreferencePage(),
                                        )
                                        )
                                        }
                              });
                              // print("res"+result);

                                    //frontend team change state according to this
                                    // setState(() {
                                    // error = 'Please supply a valid email';
                                    // });

                            }
                          },
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          child: Text("Next", style: Theme.of(context).textTheme.subtitle1,),
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

            )

          ),
      ),
    );
  }

  // Widget makeInput({label="text", obscureText = false}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: const TextStyle(
  //             fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
  //       ),
  //       const SizedBox(
  //         height: 5,
  //       ),
  //       TextFormField(
  //         key: ValueKey("ABC"),
  //         validator: (String? value){
  //           if (value == null || value.isEmpty) {
  //             return 'Please enter some text';
  //           }
  //           return null;
  //         },
  //         style: Theme.of(context).textTheme.labelMedium,
  //         onChanged: (value) {
  //           if(widget.key.toString() == "Email") {
  //             setState(() => email = value);
  //             print(email);
  //           }else if(widget.key.toString() == "Password"){
  //             setState(() => password = value);
  //             print(password);
  //           }else if(widget.key.toString() == "Confirm Password"){
  //             setState(() => confirmPassword = value);
  //             print(confirmPassword);
  //           }
  //           print(widget.key);
  //
  //         },
  //         obscureText: obscureText,
  //         decoration: InputDecoration(
  //           contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: (Colors.grey[400])!,
  //             ),
  //           ),
  //           border: OutlineInputBorder(
  //               borderSide: BorderSide(color: (Colors.grey[400])!)),
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 30,
  //       )
  //     ],
  //   );
  // }
}