import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/classes/listings.dart';
import 'package:utstyr/pages/detailedListing_page.dart';
import 'package:utstyr/pages/listing_page.dart';
import 'package:utstyr/pages/login_page.dart';
import 'package:utstyr/services/firestore_services.dart';
import 'package:utstyr/pages/messages_page.dart';
import 'package:utstyr/widgets.dart';
import 'package:utstyr/widgets/bottombar.dart';

import '../services/auth_services.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  static const String id = 'HomePage'; //Page identifier for navigation

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var allListings = Provider.of<List<Listings>>(context); //Listings provider
    var user = Provider.of<User?>(context); //User provider
    return Material(
        child: utstyrScaffold(
            //Top bar widget
            context,
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.asset(
                            'assets/images/boxwater.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                width: 300,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      )),
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () => standardNavigator(
                                  context, ListingPage(category: 'topptur')),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                      ),
                                      width: 80,
                                      height: 70,
                                      child: Icon(
                                        Icons.nordic_walking,
                                        size: 35,
                                        color: Color(0xff2C4C16),
                                      ),
                                    ),
                                  ),
                                  Text("Topptur")
                                ],
                              )),
                          InkWell(
                              child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  width: 80,
                                  height: 70,
                                  child: Icon(
                                    Icons.downhill_skiing,
                                    size: 35,
                                    color: Color(0xff2C4C16),
                                  ),
                                ),
                              ),
                              Text("Alpint")
                            ],
                          )),
                          InkWell(
                              onTap: () {
                                standardNavigator(
                                    context,
                                    ListingPage(
                                      category: 'snowboard',
                                    ));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                      ),
                                      width: 80,
                                      height: 70,
                                      child: Icon(
                                        Icons.snowboarding,
                                        size: 35,
                                        color: Color(0xff2C4C16),
                                      ),
                                    ),
                                  ),
                                  Text("Snowboard")
                                ],
                              )),
                          InkWell(
                              child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  width: 80,
                                  height: 70,
                                  child: Icon(
                                    Icons.pedal_bike,
                                    size: 35,
                                    color: Color(0xff2C4C16),
                                  ),
                                ),
                              ),
                              Text("Sykkel")
                            ],
                          )),
                          InkWell(
                              child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  width: 80,
                                  height: 70,
                                  child: Icon(
                                    Icons.map,
                                    size: 35,
                                    color: Color(0xff2C4C16),
                                  ),
                                ),
                              ),
                              Text("Camping")
                            ],
                          )),
                          InkWell(
                              child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  width: 80,
                                  height: 70,
                                  child: Icon(
                                    Icons.format_list_bulleted,
                                    size: 35,
                                    color: Color(0xff2C4C16),
                                  ),
                                ),
                              ),
                              Text("Alle kategorier")
                            ],
                          )),
                        ],
                      ),
                    ),
                    Text(
                      'Annonser nær deg',
                      style: TextStyle(fontSize: 24),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 40),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                              child: GestureDetector(
                                onTap: () => {
                                  standardNavigator(
                                      context,
                                      SingleListingPage(
                                        listingId: 'yAecmv9LiqE88snjUL3H',
                                      ))
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                  ),
                                  width: 275,
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  testList[0]['title'],
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                Text(
                                                  'Størrelse: ' +
                                                      testList[0]['størrelse'],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )
                                              ],
                                            ),
                                            Text(
                                              testList[0]['price'],
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                            child: Image.asset(
                                          'assets/images/kajakk.png',
                                          filterQuality: FilterQuality.medium,
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(25, 25, 25, 25),
                              child: GestureDetector(
                                onTap: () => {
                                  standardNavigator(
                                      context,
                                      SingleListingPage(
                                        listingId: 'yAecmv9LiqE88snjUL3H',
                                      ))
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                  ),
                                  width: 275,
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  testList[1]['title'],
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                Text(
                                                  'Størrelse: ' +
                                                      testList[1]['størrelse'],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )
                                              ],
                                            ),
                                            Text(
                                              testList[1]['price'],
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                            child: Image.asset(
                                          'assets/images/kajakk.png',
                                          filterQuality: FilterQuality.medium,
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(25, 25, 25, 25),
                              child: GestureDetector(
                                onTap: () => {
                                  standardNavigator(
                                      context,
                                      SingleListingPage(
                                        listingId: 'yAecmv9LiqE88snjUL3H',
                                      ))
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                  ),
                                  width: 275,
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  testList[2]['title'],
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                Text(
                                                  'Størrelse: ' +
                                                      testList[2]['størrelse'],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )
                                              ],
                                            ),
                                            Text(
                                              testList[2]['price'],
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                            child: Image.asset(
                                          'assets/images/kajakk.png',
                                          filterQuality: FilterQuality.medium,
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    Text(user?.email ?? 'Not logged in'),
                    ElevatedButton(
                        onPressed: () {
                          standardNavigator(context, RoomsPage());
                        },
                        child: const Text('Chats')),
                    bottombar()
                  ],
                ),
              ),
            )));
  }

  //List to mock database objects for "Listings near you" on home page.
  List testList = [
    {
      'title': 'Splitboard utstyr',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    },
    {
      'title': 'Splitboard utstyr2',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    },
    {
      'title': 'Splitboard utstyr3',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    }
  ];
}
