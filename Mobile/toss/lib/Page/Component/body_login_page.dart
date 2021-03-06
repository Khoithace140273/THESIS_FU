import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:toss/Features/display_toast.dart';
import 'package:toss/Features/textbox_decoration.dart';
import 'package:toss/Model/login_model.dart';
import 'package:toss/Page/home_page.dart';
import 'package:toss/Page/register_page.dart';
import 'package:toss/Presenter/login_presenter.dart';
import 'package:toss/View/login_view.dart';
import '../../Features/color.dart';
import '../../Features/button_decoration.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({Key? key}) : super(key: key);

  @override
  _BodyLoginState createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> implements LoginView {
  final _focusNodesUserName = FocusNode();
  final _focusNodesPassword = FocusNode();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late LoginPresenter loginPresenter;
  late LoginModel _model;

  bool _isObscure = true;
  bool _keyboardVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String get _username => _usernameController.text;
  String get _password => _passwordController.text;

  @override
  void initState() {
    super.initState();
    loginPresenter = LoginPresenter();
    loginPresenter.setView(this);
    _model = loginPresenter.model;
    _usernameController.addListener((onChangeInput));
    _passwordController.addListener((onChangeInput));

    _focusNodesUserName.addListener(() => setState(() {
          // if (_focusNodesUserName.hasFocus) {
          //   _keyboardVisible = true;
          // } else {
          //   _keyboardVisible = false;
          // }
      _keyboardVisible = !_keyboardVisible;
        }));
    _focusNodesPassword.addListener(() => setState(() {
      _keyboardVisible = !_keyboardVisible;
        }));
    KeyboardVisibilityController().onChange.listen((visible) {
      _keyboardVisible = KeyboardVisibilityController().isVisible;
    });
  }

  @override
  void dispose() {
    _focusNodesUserName.dispose();
    _focusNodesPassword.dispose();
    _isObscure = true;
    super.dispose();
  }

  @override
  void onChangeInput() {
    loginPresenter.handleOnChangeInput();
  }

  @override
  Future<void> onClickLogin(String username, String password) async {
    try {
      final result = await loginPresenter.handleLogin(username, password);
      if (result != null) {
        _usernameController.text = '';
        _passwordController.text = '';
        DisplayToast.DisplaySuccessToast(context, '????ng nh???p th??nh c??ng');
        Timer(const Duration(seconds: 3), () {
          // 5 seconds over, navigate to Page2.
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        });
      } else {
        DisplayToast.DisplayErrorToast(context, '????ng nh???p th???t b???i');
      }
    } catch (e) {
      DisplayToast.DisplayErrorToast(context, '????ng nh???p th???t b???i');
    }
  }

  @override
  void updateLoading() {
    if (mounted) {
      setState(() {
        _model.isLoading = !_model.isLoading;
      });
    }
  }

  @override
  void updateViewStatusValidation() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height:
                      _keyboardVisible ? size.width * 0.4 : size.width * 0.7,
                  width: _keyboardVisible ? size.width * 0.4 : size.width * 0.7,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/login_page_image.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: buildItemsOnScreenPadding(),
                  child: TextFormField(
                    focusNode: _focusNodesUserName,
                    cursorColor: ThemeColor(),
                    controller: _usernameController,
                    decoration: buildInputDecoration(
                        Icons.person,
                        'S??? ??i???n tho???i / Email / T??n ????ng Nh???p',
                        _focusNodesUserName.hasFocus
                            ? ThemeColor()
                            : IconColorUnFocus(),
                        'S??? ??i???n tho???i / Email / T??n ????ng Nh???p'),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Vui l??ng ??i???n ?????y ????? th??ng tin';
                      } else
                        return null;
                    },
                    onSaved: (val) {
                      // username = val!;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // password field
                Padding(
                  padding: buildItemsOnScreenPadding(),
                  child: TextFormField(
                    focusNode: _focusNodesPassword,
                    cursorColor: ThemeColor(),
                    controller: _passwordController,
                    obscureText: _isObscure,
                    decoration: buildInputDecoration(
                            Icons.lock,
                            'M???t kh???u',
                            _focusNodesPassword.hasFocus
                                ? ThemeColor()
                                : IconColorUnFocus(),
                            'M???t kh???u')
                        .copyWith(
                      suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _focusNodesPassword.hasFocus
                                ? ThemeColor()
                                : IconColorUnFocus(),
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Vui l??ng ??i???n ?????y ????? th??ng tin';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      // password = val!;
                    },
                  ),
                  //Text Button
                ),
                SizedBox(
                  height: 15,
                ),
                //Sign In Button
                Container(
                  padding: buildItemsOnScreenPadding(),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onClickLogin(_username, _password);
                      }
                    },
                    style: buttonStyleDecoration(),
                    child: textInButton('????ng Nh???p'),
                  ),
                ),
                //Sign Up
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Qu??n M???t Kh???u',
                    style: TextStyle(
                        color: ThemeColor(),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'B???n ch??a c?? t??i kho???n?  ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage())),
                      child: Text(
                        '????ng k?? ngay',
                        style: TextStyle(
                            color: ThemeColor(),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
