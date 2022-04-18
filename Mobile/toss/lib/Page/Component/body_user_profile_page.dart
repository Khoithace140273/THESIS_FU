import 'package:flutter/material.dart';
import 'package:toss/Model/Entity/user_model.dart';
import 'package:toss/Model/user_profile_model.dart';
import 'package:toss/Presenter/user_profile_presenter.dart';
import 'package:toss/View/user_profile_view.dart';

import '/Features/button_decoration.dart';
import 'profile_widget.dart';

class BodyUserProfile extends StatefulWidget {
  const BodyUserProfile({Key? key}) : super(key: key);

  @override
  State<BodyUserProfile> createState() => _BodyUserProfileState();
}

class _BodyUserProfileState extends State<BodyUserProfile> implements UserProfileView {
  late UserProfilePresenter userProfilePresenter;
  late UserProfileModel _model;

  @override
  void initState() {
    super.initState();
    userProfilePresenter = UserProfilePresenter();
    userProfilePresenter.setView(this);
    _model = userProfilePresenter.model;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ProfileWidget(
          imagePath: '',
          onClicked: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //       builder: (context) => const EditProfilePage()),
            // );
          },
        ),
        const SizedBox(height: 24),
        buildName(_model.user),
        const SizedBox(height: 24),
        Center(child: ElevatedButton(style: buttonStyleDecoration(),
          child: textInButton('Sửa thông tin cá nhân'),
          onPressed: () => {},)),
        const SizedBox(height: 24),
        Center(child: ElevatedButton(style: buttonStyleDecoration(),
          child: textInButton('Đăng xuất'),
          onPressed: () => {},)),
      ],
    );
  }

  Widget buildName(UserModel user) =>
      Column(
        children: [
          Text(
            user.fullname!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email!,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            user.gender == 1 ? 'Nam' : 'Nữ',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            user.phoneNumber!,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            user.location!,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  @override
  void updateLoading() {
    // TODO: implement updateLoading
  }

}
