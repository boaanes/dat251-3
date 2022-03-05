import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/pages/home_page.dart';
import 'package:utstyr/services/auth_services.dart';
import '../widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    bool loggedIn = user != null;

    return loggedIn
        ? Home()
        : utstyrScaffold(
            context,
            Column(
              children: [
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        AuthenticateService().signInWithEmailAndPassword(
                            'theodornorill@gmail.com', 'Friluft1234');
                      },
                      child: const Text('Knapp for å logge inn')),
                ),
              ],
            ),
          );
  }
}
