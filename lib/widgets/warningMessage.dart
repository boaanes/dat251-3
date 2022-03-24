import 'package:flutter/material.dart';

Widget warningMsg(msg) {
  var alert = {
    "listing": "Du må være logget inn for å kunne opprette en annonse"
  };
  var alertm = alert[msg];
  return Container(
    width: 450,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.orange[100],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Icon(
            Icons.warning,
            color: Colors.orange[800],
          ),
        ),
        Text(
          alertm!,
          style: TextStyle(color: Colors.orange[800]),
        ),
      ],
    ),
  );
}
