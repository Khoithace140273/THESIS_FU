import 'package:flutter/material.dart';
import 'package:toss/Page/Component/body_home_page.dart';
import 'package:toss/Page/component/body_login_page.dart';

import '../Features/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(backgroundColor: ThemeColor(), body: const BodyHomePage());
}
