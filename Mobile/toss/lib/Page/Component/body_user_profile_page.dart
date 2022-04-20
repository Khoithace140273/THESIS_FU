import 'package:flutter/material.dart';
import 'package:toss/Model/Entity/user_model.dart';
import 'package:toss/Model/user_profile_model.dart';
import 'package:toss/Features/user_profile_widget.dart';
import 'package:toss/Page/Component/body_edit_user_profile.dart';
import 'package:toss/Presenter/user_profile_presenter.dart';
import 'package:toss/View/user_profile_view.dart';
import '/Features/button_decoration.dart';
import 'avatar_widget.dart';

class BodyUserProfile extends StatefulWidget {
  const BodyUserProfile({Key? key}) : super(key: key);

  @override
  State<BodyUserProfile> createState() => _BodyUserProfileState();
}

class _BodyUserProfileState extends State<BodyUserProfile>
    implements UserProfileView {
  late UserProfilePresenter userProfilePresenter;
  late UserProfileModel _model;
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    userProfilePresenter = UserProfilePresenter();
    userProfilePresenter.setView(this);
    _model = userProfilePresenter.model;
    _isEditing = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AvatarWidget(
            imagePath: 'assets/user (1).png',
            onClicked: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //       builder: (context) => const EditProfilePage()),
              // );
            },
          ),
          const SizedBox(
              height: 24,
              child: Divider(
                thickness: 5,
              )),
          buildHeader(),
          const SizedBox(height: 15,),
          _isEditing ? const BodyEditUserProfile() :buildName(_model.user),
        ],
      ),
    );
  }

  Widget buildHeader() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Thông tin cá nhân', style: buildHeaderTextStyle()),
            InkWell(
              child: Text('Sửa', style: _isEditing?buildHeaderTextStyle().copyWith(decoration: TextDecoration.underline):buildHeaderTextStyle()),
              onTap: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
            )
          ],
        ),
      );

  Widget buildName(UserModel user) => Column(
        children: [
          Text(
            user.fullname!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
          ),
          const SizedBox(height: 15),
          buildRowProfile(Icons.mail, user.email!),
          const SizedBox(height: 15),
          user.gender == 1 ? buildRowProfile(Icons.male, 'Nam') : buildRowProfile(Icons.female, 'Nữ'),
          const SizedBox(height: 15),
          buildRowProfile(Icons.phone, user.phoneNumber!),
          const SizedBox(height: 15),
          buildRowProfile(Icons.location_on, user.location!),
          const SizedBox(height: 24),
          ElevatedButton(
            style: buttonStyleDecoration(),
            child: textInButton('Đăng xuất'),
            onPressed: () => {},
          )
        ],
      );

  @override
  void updateLoading() {
    // TODO: implement updateLoading
  }
}
