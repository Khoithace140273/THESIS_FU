import 'package:flutter/material.dart';
import 'package:toss/Features/customize_app_bar.dart';
import 'package:toss/Page/component/body_register_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(context, 'Tạo tài khoản mới'),
      body: const BodyRegister(),
      resizeToAvoidBottomInset: true,
    );
  }
}
