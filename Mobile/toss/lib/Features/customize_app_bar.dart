// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

BuildAppBar(BuildContext context, String title) => AppBar(
  backgroundColor: Colors.transparent,
  shadowColor: Colors.transparent,
  leading: IconButton(
    icon: const Icon(
      Icons.arrow_back_ios_new,
      color: Colors.black,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
  title: Text(title, style: const TextStyle(color: Colors.black)),
  centerTitle: true,
);