import 'package:flutter/material.dart';

Future standardNavigator(context, page) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration(seconds: 0),
    ),
  );
}
