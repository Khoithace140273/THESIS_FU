import 'package:flutter/material.dart';
import 'package:toss/Features/customize_app_bar.dart';

import 'Component/body_user_profile_page.dart';
class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(appBar: BuildAppBar(context, 'Hồ sơ cá nhân'), body: const BodyUserProfile());
}
