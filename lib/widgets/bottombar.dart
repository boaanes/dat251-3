import 'package:flutter/material.dart';

//Bottom bar widget to be used on all pages
Widget bottombar() {
  return Column(
    children: [
      Container(
        height: 1,
        color: Color.fromARGB(255, 209, 205, 205),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                        text: 'Ut',
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 39, 25),
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: 'styr',
                              style: TextStyle(color: Color(0xffA9BE98)))
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                    child: Text('2022 © Utstyr'),
                  ),
                  Text('All rights reserved')
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Home",
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Pricing",
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "About us",
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Contact",
                    ),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Facebook",
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Instagram",
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Twitter",
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "LinkedIn",
                    ),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              height: 45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Privacy Policy",
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Terms Of Service",
                    ),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      )
    ],
  );
}
