import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Tạo tài khoản mới', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: BodyRegister(),
      resizeToAvoidBottomInset: true,
    );
  }
}
