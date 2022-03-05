import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Scaffold widget to use throughout the app
Widget utstyrScaffold(context, bodyContent) {
  final authStatus = Provider.of<User?>(context);
  return Scaffold(
    appBar: AppBar(
      actions: [
        InkWell(
          child: const Text('Sjekk om logget inn eller ikke'),
          onTap: () {
            print(authStatus?.email);
            //TODO: Navigator to create annonse
          },
        ),
        ElevatedButton(
            onPressed: () {
              //Navigate to log in
            },
            child:
                const Text('Logg inn')) //TODO: Change according to log in state
      ],
      title: const Text('Utstyr'),
      automaticallyImplyLeading: false,
    ),
    body: bodyContent,
  );
}
