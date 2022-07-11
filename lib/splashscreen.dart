import 'package:flutter/material.dart';
import 'package:musicplayer/bottombar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotohome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/AF4-removebg-preview (1).png'),
            const Padding(
              padding: EdgeInsets.only(left: 30, top: 50),
              child: Text(
                'The Only Truth Is Music...',
                style: TextStyle(color: Color.fromARGB(255, 151, 150, 150)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> gotohome() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const BottomScreen()));
  }
}
