import 'package:flutter/material.dart';

class BlankPage extends StatefulWidget{
  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
    );
  }
}