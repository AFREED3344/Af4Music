import 'package:flutter/material.dart';
import 'package:musicplayer/home_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(
                MaterialPageRoute(builder: ((context) => const ScreenHome())));
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: const Color.fromARGB(255, 202, 200, 200),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                'Settings',
                style: TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 206, 202, 202)),
              ),
              // Spacer(),
              SizedBox(
                width: 150,
              ),
              Icon(
                Icons.settings,
                color: Color.fromARGB(255, 195, 192, 192),
                size: 35,
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Divider(
              thickness: 0.5,
              color: Color.fromARGB(255, 183, 182, 182),
            ),
          ),
          const ListTile(
            title: Text(
              'About',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const ListTile(
            title: Text(
              'Privacy Policy',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const ListTile(
            title: Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
}
