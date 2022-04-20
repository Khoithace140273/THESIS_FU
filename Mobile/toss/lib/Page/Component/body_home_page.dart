import 'package:flutter/material.dart';
import 'package:toss/Features/button_decoration.dart';
import 'package:toss/Page/nearest_hospital_page.dart';
import 'package:toss/Page/user_profile_page.dart';

class BodyHomePage extends StatelessWidget {
  const BodyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height/15,
              width: size.width*0.75,
                child: buildHomePageButton(context, 'assets/user (1).png', 'Hồ sơ cá nhân', const UserProfile())
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: size.height/15,
              width: size.width*0.75,
              child: buildHomePageButton(context, 'assets/news.png', 'Tin tức sức khỏe', SizedBox.shrink()),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: size.height/15,
              width: size.width*0.75,
              child: buildHomePageButton(context, 'assets/user (1).png', 'Bệnh viện gần nhất', const NearestHospital()),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height/15,
              width: size.width*0.75,
              child: buildHomePageButton(context, 'assets/user (1).png', 'Yêu cầu hỗ trợ', SizedBox.shrink()),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height/15,
              width: size.width*0.75,
              child: buildHomePageButton(context, 'assets/user (1).png', 'Lịch sử tư vấn', SizedBox.shrink()),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.height/15,
              width: size.width*0.75,
              child: buildHomePageButton(context, 'assets/user (1).png', 'Tư vấn cùng bác sĩ', SizedBox.shrink()),
            ),
          ],
        ),
      ),
    );
  }
}
