import 'dart:ui';

import 'package:flutter/material.dart';

import '../Controller/services/UserController.dart';
import 'EntryPage.dart';
import 'SignUp.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<UserProfilePage> {

  Map<String, dynamic> userDetails = UserController.getProfileDetails();
  Diet? _diet = Diet.vegan;


  @override
  void initState() {
    if(userDetails["vegetarian"]){
      _diet = Diet.vegetarian;
    }else if(userDetails["vegan"]){
      _diet = Diet.vegan;
    }else{
      _diet = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: Theme.of(context).textTheme.subtitle1),

        centerTitle: true,

        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            )),
      ),

      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(top:30),
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
                minRadius: 64,
              )
            ),

            SizedBox(height: 15,),

            Center(
              child: Text(
                userDetails["name"][0].toUpperCase() + userDetails["name"].substring(1),
                style: Theme.of(context).textTheme.labelMedium,
              )
            ),

            SizedBox(height: 5),

            Center(
              child: Text(
                userDetails["email"],
                style: Theme.of(context).textTheme.bodyText1,
              )
            ),

            SizedBox(height: 30),

            Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Fridge Details", style: Theme.of(context).textTheme.headline4),
                  ),

                  ListTile(
                    title: Text('Compartments', style: Theme.of(context).textTheme.bodyText1),
                    trailing: Text(userDetails["fridgeDetails"].toString(), style: Theme.of(context).textTheme.bodyText1),
                  )
                ]
            ),

            Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Dietary Preferences", style: Theme.of(context).textTheme.headline4),
                  ),

                  RadioListTile<Diet>(
                      activeColor: Colors.grey,
                      selectedTileColor: Colors.grey,
                      toggleable: true,
                      title: Text(
                        'Vegetarian',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      value: Diet.vegetarian,
                      groupValue: _diet,
                      onChanged: (Diet? value) {
                        setState(() {

                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing),

                  const Divider(indent: 15.0, endIndent: 15.0, height: 1.0),

                  RadioListTile<Diet>(
                      activeColor: Colors.grey,
                      selectedTileColor: Colors.grey,
                      toggleable: true,
                      title: Text(
                        'Vegan',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      value: Diet.vegan,
                      groupValue: _diet,
                      onChanged: (Diet? value) {
                        setState(() {

                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing),
                ]
            ),

            const Divider(indent: 15.0, endIndent: 15.0, height: 1.0),

            Column(
                children: [ListTile(
                  title:
                  Text("Allergens", style: Theme.of(context).textTheme.headline4),
                ),
                CheckboxListTile(
                  activeColor: Colors.grey,
                  selectedTileColor: Colors.grey,
                  // checkColor: Colors.grey,
                  title: Text('Gluten Free', style: Theme.of(context).textTheme.bodyText1),
                  value: userDetails["glutenFree"],
                  onChanged: (bool? value) {
                    setState(() {
                      // developer.log(_glutenFree.toString());
                    });
                  },
                ),
                const Divider(indent: 15.0, endIndent: 15.0, height: 1.0),
                CheckboxListTile(
                  activeColor: Colors.grey,
                  selectedTileColor: Colors.grey,
                  title: Text('Dairy Free', style: Theme.of(context).textTheme.bodyText1),
                  value: userDetails["dairyFree"],
                  onChanged: (bool? value) {
                    setState(() {
                      // developer.log(_glutenFree.toString());
                    });
                  },
                ),
                ]
            ),
            const Divider(indent: 15.0, endIndent: 15.0, height: 1.0),

            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                margin: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => EntryPage(title: 'FIT',)));
                  },
                    //need to change to email, for now hardcoded
                    // await UserController.retrieveDetails(email);
                    // await UserController.setData();
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    "Log Out",
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1,
                  ),
                ),
              ),
            )
          ]
        )
      )
    );
  }

}