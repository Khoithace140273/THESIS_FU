import 'package:flutter/material.dart';
import 'package:toss/Page/login_page.dart';

class SlashPage extends StatefulWidget {
  const SlashPage({Key? key}) : super(key: key);

  @override
  _SlashPageState createState() => _SlashPageState();
}

class _SlashPageState extends State<SlashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Color(0xFF039D78),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Image.asset("assets/launch_splash_image.png")),
            Container(
              child: Text(
                'TOSS',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
