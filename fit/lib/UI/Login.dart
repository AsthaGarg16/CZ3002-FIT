import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login", style:Theme.of(context).textTheme.subtitle1),
        titleSpacing: 0,
        leading: IconButton( onPressed: (){
          Navigator.pop(context);
        },icon:const Icon(Icons.arrow_back_ios,size: 20,color: Colors.white70,)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Column(
                  children: [

                    Text("Welcome back!",style: Theme.of(context).textTheme.subtitle2,),
                    const SizedBox(height: 15,),
                    Text("Login with your credentials",style: Theme.of(context).textTheme.bodyText1,),
                    const SizedBox(height: 35,),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40
                  ),
                  child: Column(
                    children: [
                      makeInput(label: "Email :"),
                      makeInput(label: "Password :",obscureText: true),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(100, 0, 100, 0),

                    child: MaterialButton(
                      minWidth: double.infinity,
                      height:60,
                      onPressed: (){},
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: Text("Login",style: Theme.of(context).textTheme.subtitle1,),
                    ),

                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width:10,),
                    Text("Sign Up",style: Theme.of(context).textTheme.labelMedium,),
                  ],
                )
              ],

            ),
          ],
        ),
      ),
    );
  }
}

Widget makeInput({label,obscureText = false}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,style:TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
      ),),
      SizedBox(height: 5,),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: (Colors.grey[400])!,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: (Colors.grey[400])!)
          ),
        ),
      ),
      SizedBox(height: 30,)

    ],
  );
}