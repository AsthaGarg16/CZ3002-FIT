import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {

  static String videoID = 'Zrzff5unx6o';


  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: videoID,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Help", style: Theme.of(context).textTheme.subtitle1),

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

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height:20),
            const Text(" Prototype Walkthrough", style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                letterSpacing: 2.0),),
            const SizedBox(height:10),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: (
                  YoutubePlayer(
                    controller: _controller,
                    liveUIColor: Colors.amber,
                    showVideoProgressIndicator: true,
                  )),
            )
          ]

        )


    );

  }

}