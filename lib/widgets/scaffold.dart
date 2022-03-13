import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/pages/home_page.dart';
import 'package:utstyr/services/auth_services.dart';

import '../pages/login_page.dart';
import '../widgets.dart';

//EDEDED
//Scaffold widget to use throughout the app
Widget utstyrScaffold(context, bodyContent) {
  final authStatus = Provider.of<User?>(context);
  return Scaffold(
    backgroundColor: const Color(0xffEDEDED),
    appBar: AppBar(
      elevation: 0,
      backgroundColor: const Color(0xffEDEDED),
      actions: [
        InkWell(
          child: const Center(
              child: Text(
            'Lag annonse',
            style: TextStyle(color: Color(0xff737373)),
          )),
          onTap: () {
            print(authStatus?.email);
            //TODO: Navigator to create annonse
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 10, 100, 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: const Color(0xff2C4C16)),
              onPressed: () {
                (authStatus?.uid != null)
                    ? AuthenticateService().signOut()
                    : standardNavigator(context, LoginPage());
              },
              child: Text((authStatus?.uid != null) ? 'Logg ut' : 'Logg inn')),
        ) //TODO: Change according to log in state
      ],
      title: Padding(
          padding: const EdgeInsets.fromLTRB(75, 0, 0, 0),
          child: InkWell(
            onTap: () {
              standardNavigator(context, Home());
            },
            child: RichText(
              text: const TextSpan(
                  text: 'Ut',
                  style: TextStyle(
                      color: Color.fromARGB(255, 31, 39, 25),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: 'styr',
                        style: TextStyle(color: Color(0xffA9BE98)))
                  ]),
            ),
          )),
      automaticallyImplyLeading: false,
    ),
    body: bodyContent,
  );
}
