import 'package:flutter/material.dart';
import 'color.dart';

Widget buildRowProfile(IconData icon, String info) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 80),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: ThemeColor(),
          ),
          const SizedBox(width: 10,),
          Text(info,
              style: buildInfoTextStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis)
        ],
      ),
    );

TextStyle buildInfoTextStyle() => const TextStyle(color: Colors.black, fontSize: 22);

TextStyle buildHeaderTextStyle() =>
    TextStyle(color: ThemeColor(), fontSize: 21, fontWeight: FontWeight.w600);
