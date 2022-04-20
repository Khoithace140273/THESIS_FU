import 'package:flutter/material.dart';
import 'package:toss/Features/customize_app_bar.dart';

import 'Component/body_nearest_hospital.dart';
class NearestHospital extends StatelessWidget {
  const NearestHospital({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(appBar: BuildAppBar(context, 'Bệnh viện gần nhất'), body: const BodyNearestHospital());
}
