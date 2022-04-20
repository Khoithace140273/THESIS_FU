import 'package:flutter/material.dart';

import '../../Features/hospital_tile.dart';

class BodyNearestHospital extends StatefulWidget {
  const BodyNearestHospital({Key? key}) : super(key: key);

  @override
  State<BodyNearestHospital> createState() => _BodyNearestHospitalState();
}

class _BodyNearestHospitalState extends State<BodyNearestHospital> {
  List <int> hospital = [1,2,3];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hospital.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        var recent = hospital[index];
        return InkWell(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 160.0,
            margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
            child: HospitalTile(hospital: recent),
          ),
        );
      },
    );
  }
}
