import 'package:fit/Controller/services/auth.dart';
import 'package:flutter/material.dart';

import './HomePage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login", style: Theme.of(context).textTheme.subtitle1),
        titleSpacing: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white70,
            )),
      ),
      body: Container(
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
                      children: [
                        Text(
                          "Welcome back!",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Login with your credentials",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Email: ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: (Colors.grey[400])!,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: (Colors.grey[400])!)),
                                ),
                                style: Theme.of(context).textTheme.bodyText1,
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: (Colors.grey[400])!,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: (Colors.grey[400])!)),
                                ),
                                style: Theme.of(context).textTheme.bodyText1,
                                validator: (String? value) {
                                  if (value != null && value.isEmpty) {
                                    return "Please enter a password";
                                  }
                                  if (value != null && value.length < 6) {
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
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () async {
                          print(email);
                          print(password);
                          //Navigator.of(context).push(MaterialPageRoute(
                          //    builder: (BuildContext context) => HomePage()));
                          if (_formKey.currentState!.validate()) {
                            await _auth
                                .signIn(email, password)
                                .then((loginSuccess) => {
                                      if (loginSuccess)
                                        {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          HomePage()))
                                        }
                                    });
                          }
                        },
                        color: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        child: Text(
                          "Login",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Don't have an account?"),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign Up",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

  // Widget makeInput({label, obscureText = false}) {
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


