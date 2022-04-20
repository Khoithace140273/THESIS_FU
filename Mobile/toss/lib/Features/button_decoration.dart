import 'package:flutter/material.dart';

import 'color.dart';

buttonStyleDecoration() => TextButton.styleFrom(
    backgroundColor: ThemeColor(),
    padding: const EdgeInsets.symmetric(vertical: 17));

textInButton(String content) => Text(
      content,
      style: const TextStyle(color: Colors.white, fontSize: 19),
    );

buildHomePageButton(
        BuildContext context, String iconUrl, String title, Widget page) =>
    ElevatedButton.icon(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      icon: Image.asset(iconUrl),
      style: TextButton.styleFrom(
          backgroundColor: Colors.white, alignment: Alignment.centerLeft),
      label: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 19,
        ),
      ),
    );
