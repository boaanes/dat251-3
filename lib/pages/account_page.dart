import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/classes/listings.dart';
import 'package:utstyr/pages/detailedListing_page.dart';
import 'package:utstyr/pages/home_page.dart';
import 'package:utstyr/pages/listing_page.dart';
import 'package:utstyr/pages/login_page.dart';
import 'package:utstyr/services/firestore_services.dart';
import 'package:utstyr/pages/messages_page.dart';
import 'package:utstyr/widgets.dart';
import 'package:utstyr/widgets/bottombar.dart';

import '../services/auth_services.dart';

class MyAccount extends StatefulWidget {
  MyAccount({Key? key}) : super(key: key);
  static const String id = 'AccountPage'; //Page identifier for navigation

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    var allListings = Provider.of<List<Listings>>(context); //Listings provider
    var user = Provider.of<User?>(context); //User provider
    return Material(
        child: utstyrScaffold(
            //Top bar widget
            context,
            SingleChildScrollView(
                child: Align(
              alignment: Alignment.center,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  width: 400,
                  height: 600,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(50),
                          child: Text(
                            "Min konto",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(25),
                            child: InkWell(
                              onTap: () {
                                standardNavigator(context, RoomsPage());
                              },
                              child: Text(
                                "Meldinger",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 22),
                                textAlign: TextAlign.left,
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(25),
                            child: Text(
                              "Mine annonser",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22),
                              textAlign: TextAlign.left,
                            )),
                        Padding(
                            padding: EdgeInsets.all(25),
                            child: Text(
                              "Lagrede annonser",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22),
                              textAlign: TextAlign.left,
                            )),
                        Padding(
                            padding: EdgeInsets.all(25),
                            child: Text(
                              "Instillinger",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22),
                              textAlign: TextAlign.left,
                            )),
                        Padding(
                            padding: EdgeInsets.all(25),
                            child: InkWell(
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                standardNavigator(context, Home());
                              },
                              child: Text(
                                "Logg ut",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 22),
                                textAlign: TextAlign.left,
                              ),
                            ))
                      ])),
            ))));
  }
}
