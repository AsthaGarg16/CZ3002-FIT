// import 'dart:ui';
//
// import 'package:fit/Entity/FoodItem.dart';
// import 'package:flutter/material.dart';
//
//
//
//   Future<void> showCustomDialog(BuildContext context,
//       {String title = "Add item",
//         String okBtnText = "Save",
//         String cancelBtnText = "Cancel" }) {
//
//     FoodItem newItem ;
//     String _name;
//     int  _quantity;
//     String _unit;
//     bool _status=false;
//     bool _inventory_status=false;
//     bool _from_saved_recipes=false;
//     String _recipeID="";
//
//     final GlobalKey<FormState> _dialogformKey = GlobalKey<FormState>();
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(title),
//             content: Container(
//
//                   child: Column(
//                       children: <Widget>[
//                       Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Form(
//                             key: _dialogformKey,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Column(
//                                       children: [
//                                         Text(
//                                           "Add item",
//                                           style: Theme
//                                               .of(context)
//                                               .textTheme
//                                               .subtitle2,
//                                         ),
//                                         const SizedBox(
//                                           height: 15,
//                                         ),
//
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 40),
//                                       child: Column(
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               const Text(
//                                                 "Item name: ",
//                                                 style: TextStyle(
//                                                     fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//                                               ),
//                                               const SizedBox(
//                                                 height: 5,
//                                               ),
//                                               TextFormField(
//                                                 obscureText: false,
//                                                 decoration: InputDecoration(
//                                                   contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                                                   enabledBorder: OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: (Colors.grey[400])!,
//                                                     ),
//                                                   ),
//                                                   border: OutlineInputBorder(
//                                                       borderSide: BorderSide(color: (Colors.grey[400])!)),
//                                                 ),
//                                                 style: Theme
//                                                     .of(context)
//                                                     .textTheme
//                                                     .bodyText1,
//                                                 validator: (String? value) {
//                                                   if (value != null && value.isEmpty) {
//                                                     return "Please enter the name of the item";
//                                                   }
//
//                                                   return null;
//                                                 },
//                                                 onChanged: (val) {
//                                                   setState(() => _name = val);
//                                                 },
//                                               ),
//                                               const SizedBox(
//                                                 height: 30,
//                                               )
//                                             ],
//                                           ),
//                                           Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               const Text(
//                                                 "Password: ",
//                                                 style: TextStyle(
//                                                     fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//                                               ),
//                                               const SizedBox(
//                                                 height: 5,
//                                               ),
//                                               TextFormField(
//                                                 obscureText: true,
//                                                 decoration: InputDecoration(
//                                                   contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                                                   enabledBorder: OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: (Colors.grey[400])!,
//                                                     ),
//                                                   ),
//                                                   border: OutlineInputBorder(
//                                                       borderSide: BorderSide(color: (Colors.grey[400])!)),
//                                                 ),
//                                                 style: Theme
//                                                     .of(context)
//                                                     .textTheme
//                                                     .bodyText1,
//
//                                                 validator: (String? value) {
//                                                   if (value != null && value.isEmpty) {
//                                                     return "Please enter a password";
//                                                   }
//                                                   if (value != null && value.length<6) {
//                                                     return "Enter a password 6+ chars long";
//                                                   }
//
//                                                   return null;
//                                                 },
//                                                 onChanged: (val) {
//                                                   setState(() => password = val);
//                                                 },
//                                               ),
//                                               const SizedBox(
//                                                 height: 30,
//                                               )
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.fromLTRB(100, 0, 100, 0),
//                                       child: MaterialButton(
//                                         minWidth: double.infinity,
//                                         height: 60,
//                                         onPressed: ()async{
//                                           print(email);
//                                           print(password);
//                                           Navigator.of(context).push(MaterialPageRoute(
//                                               builder: (BuildContext context) => HomePage()));
//                                           // if(_formKey.currentState!.validate())
//                                           //   {
//                                           //     await _auth
//                                           //         .signIn(
//                                           //         email, password).then((loginSuccess)=>{
//                                           //           if(loginSuccess){
//                                           //     Navigator.of(context).push(MaterialPageRoute(
//                                           //         builder: (BuildContext context) => HomePage()))
//                                           //           }
//                                           //         });
//                                           //   }
//
//                                         },
//                                         color: Theme
//                                             .of(context)
//                                             .colorScheme
//                                             .primary,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(40)),
//                                         child: Text(
//                                           "Login",
//                                           style: Theme
//                                               .of(context)
//                                               .textTheme
//                                               .subtitle1,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                       children: [
//                                         Text("Don't have an account?",
//                                           style: Theme
//                                               .of(context)
//                                               .textTheme
//                                               .labelMedium,),
//                                         const SizedBox(
//                                           width: 10,
//                                         ),
//                                         Text(
//                                           "Sign Up",
//                                           style: Theme
//                                               .of(context)
//                                               .textTheme
//                                               .labelMedium,
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ))
//                         Text(
//                           "Item name: ",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.normal,
//                               color: Colors.black87,
//                               letterSpacing: 0.5),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//
//
//                         TextField(
//                           obscureText: false,
//
//                           decoration: InputDecoration(
//                             isDense: true,
//
//                             contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 8, horizontal: 8),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: (Colors.grey[400])!,
//                               ),
//                             ),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: (Colors.grey[400])!)),
//                           ),
//                           style: Theme
//                               .of(context)
//                               .textTheme
//                               .bodyText1,
//                           onChanged: (val) {
//                             ;
//                           },
//                         ),
//                       ],
//                     ),
//                       const SizedBox(
//                       height: 20.0
//                       ),
//                       Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                             const Text(
//                             "Quantity: ",
//                             style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.normal,
//                             color: Colors.black87,
//                             letterSpacing: 0.5),
//                             ),
//                             const SizedBox(
//                             height: 5,
//                             ),
//                             TextField(
//                               obscureText: false,
//
//                               decoration: InputDecoration(
//                               isDense: true,
//
//                               contentPadding: const EdgeInsets.symmetric(
//                               vertical: 8, horizontal: 8),
//                               enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                               color: (Colors.grey[400])!,
//                               ),
//                               ),
//                               border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                               color: (Colors.grey[400])!)),
//                               ),
//                               style: Theme
//                                   .of(context)
//                                   .textTheme
//                                   .bodyText1,
//                               onChanged: (val) {
//                               ;
//                               },
//                               ),
//                             ],
//                       ),
//                       const SizedBox(
//                       height: 10.0
//                       ),
//                       Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                             const Text(
//                             "Unit: ",
//                             style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.normal,
//                             color: Colors.black87,
//                             letterSpacing: 0.5),
//                             ),
//                             const SizedBox(
//                             height: 5,
//                             ),
//                             TextField(
//                             obscureText: false,
//
//                             decoration: InputDecoration(
//                             isDense: true,
//
//                             contentPadding: const EdgeInsets.symmetric(
//                             vertical: 8, horizontal: 8),
//                             enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                             color: (Colors.grey[400])!,
//                             ),
//                             ),
//                             border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                             color: (Colors.grey[400])!)),
//                             ),
//                             style: Theme
//                                 .of(context)
//                                 .textTheme
//                                 .bodyText1,
//                             onChanged: (val) {
//                             ;
//                             },
//                             ),
//                             ],
//                             ),
//
//                       ]
//           )),
//             actions: <Widget>[
//               MaterialButton(
//               onPressed: () {
//
//                 Navigator.pop(context);
//           },
//               color: Theme
//                   .of(context)
//                   .colorScheme
//                   .primary,
//               shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10)),
//                   child: Text(okBtnText, style: const TextStyle(fontSize: 14.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white)),
//           ),
//               MaterialButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 color: Theme
//                     .of(context)
//                     .colorScheme
//                     .primary,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Text(cancelBtnText, style: const TextStyle(fontSize: 14.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white)),
//               )
//             ],
//           );
//         });
//   }
