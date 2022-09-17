import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/about.dart';
import 'package:musicplayer/database/model.dart';
import 'package:musicplayer/home_screen.dart';
import 'package:musicplayer/privacy.dart';
import 'package:musicplayer/splashscreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 206, 202, 202)),
                ),
                Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 195, 192, 192),
                  size: 35,
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 0.5,
                color: Color.fromARGB(255, 183, 182, 182),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ));
                },
                child: const Text(
                  'About',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => PrivacyScreen())));
                },
                child: const Text('Privacy and Policy',
                    style: TextStyle(color: Colors.white, fontSize: 17))),
            TextButton(
                onPressed: () {
                  clearDatabase(context);
                },
                child: const Text('Reset',
                    style: TextStyle(color: Colors.white, fontSize: 17))),
            const SizedBox(
              height: 400,
            ),
            const Center(
              child: Text(
                'Version 0.1.1',
                style: TextStyle(color: Color.fromARGB(255, 126, 123, 123)),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> clearDatabase(context) async {
    AlertDialog alert = AlertDialog(
      title: const Text("Alert !"),
      content: const Text("Would you like to Reset Yout App?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('cancel')),
        TextButton(
            onPressed: () {
              setState(() {
                Hive.box<int>('favoriteDB').clear();

                Hive.box<MusicModel>('playlist').clear();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const SplashScreen()));
              });
            },
            child: const Text('Continue')),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
