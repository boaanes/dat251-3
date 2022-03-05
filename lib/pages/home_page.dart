import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/pages/login_page.dart';
import 'package:utstyr/widgets.dart';

import '../services/auth_services.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  static const String id = 'HomePage';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: utstyrScaffold(
            context,
            Column(
              children: [
                Text('Home page'),
                ElevatedButton(
                  onPressed: () {
                    standardNavigator(context, LoginPage());
                  },
                  child: Text('Login page'),
                ),
                ElevatedButton(
                    onPressed: () {
                      AuthenticateService().signOut();
                    },
                    child: const Text('Logg ut')),
              ],
            )));
  }
}
