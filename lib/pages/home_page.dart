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
    var user = Provider.of<User?>(context);
    return Material(
        child: utstyrScaffold(
            context,
            Column(
              children: [
                Text(user?.email ?? 'Not logged in'),
                (user?.email != null)
                    ? Center(
                        child: ElevatedButton(
                            onPressed: () {
                              AuthenticateService().signOut();
                            },
                            child: const Text('Logg ut')),
                      )
                    : Container(),
              ],
            )));
  }
}
