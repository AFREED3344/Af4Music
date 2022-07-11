import 'package:flutter/material.dart';
import 'package:musicplayer/splashscreen.dart';

main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        backgroundColor: Colors.black
      ),
      home: const SplashScreen(),
      
      
    );
  }
}