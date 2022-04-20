import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget renterInfo(String renterid) {
  return Align(
    alignment: Alignment.topLeft,
    child: Column(
      children: [
        Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Utleier',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(143, 172, 120, 57)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    'Ola Norman',
                    style: TextStyle(
                      fontSize: 18,
                      height: 2,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 15, 0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person_outline_rounded,
                  color: Color.fromRGBO(143, 172, 120, 57),
                  size: 80,
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Erfaren Utleier',
            style: TextStyle(
              fontSize: 16,
              height: 2,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Bergen, Hordaland',
            style: TextStyle(
              fontSize: 16,
              height: 2,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Svarer vanligvis innen få minutter',
            style: TextStyle(
              fontSize: 14,
              height: 2,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 11),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Send melding'),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(143, 172, 120, 57), // Background color
              onPrimary: Colors.white, // Text Color (Foreground color)
            ),
          ),
        ),
      ],
    ),
  );
}
