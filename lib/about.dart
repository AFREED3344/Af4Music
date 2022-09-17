import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'About',
          style: TextStyle(
              color: Color.fromARGB(255, 228, 220, 220), fontSize: 25),
        ),
      ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 50),
            child: Text(
              'af4 music',
              style: TextStyle(
                  color: Color.fromARGB(255, 228, 220, 220),
                  fontSize: 25,
                  fontWeight: FontWeight.w100),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 50),
            child: Text(
              'A MUSIC PLAYER APPLICATION BY MUHAMMED AFREED. ITS A FINISHED DISCONNECTED MUSIC PLAYER , THATYOU CAN HEAR  TUNES WITHOUT WEB. BY THIS APPLICATION YOU CAN ENCOUNTER  THE MUSIC IN THE STYLE AS LIKE A WEB - BASED MUSIC PLAYER SHOW',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
