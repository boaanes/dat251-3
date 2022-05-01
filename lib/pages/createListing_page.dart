import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/classes/listings.dart';
import 'package:utstyr/pages/login_page.dart';
import 'package:utstyr/services/firestore_services.dart';
import 'package:utstyr/widgets/bottombar.dart';
import 'package:utstyr/widgets/scaffold.dart';

import '../widgets/standardNavigator.dart';
import 'account_page.dart';

class CreateListing extends StatefulWidget {
  const CreateListing({Key? key}) : super(key: key);

  @override
  State<CreateListing> createState() => _CreateListingState();
}

class _CreateListingState extends State<CreateListing> {
  bool individualRent = false;
  bool packagePrice = false;
  bool oneDayPrice = false;
  bool oneWeekPrice = false;
  TextEditingController titleInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  TextEditingController priceInput = TextEditingController();
  TextEditingController categoryInput = TextEditingController();
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    bool loggedIn = user != null;
    return loggedIn
        ? Material(
            child: utstyrScaffold(
                context,
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(100, 50, 100, 0),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ny annonse',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 25, 0, 10),
                                          child: Text(
                                            'Tittel',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                          width: 500,
                                          child: TextFormField(
                                            controller: titleInput,
                                            cursorColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            decoration: InputDecoration(
                                                focusColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                filled: true,
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                fillColor: Colors.grey[50],
                                                border: const OutlineInputBorder(),
                                                hintText: "Eks. Terrengsykkel - Scott Genius 920 XT 21",
                                                hintStyle: TextStyle(color: Colors.grey[400])),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 25, 0, 10),
                                          child: Text(
                                            'Kategori',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                          width: 500,
                                          child: TextFormField(
                                            controller: categoryInput,
                                            cursorColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            decoration: InputDecoration(
                                                focusColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                filled: true,
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                fillColor: Colors.grey[50],
                                                border: const OutlineInputBorder(),
                                                hintText: "Eks. Friluftsliv",
                                                hintStyle: TextStyle(color: Colors.grey[400])),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 25, 0, 10),
                                          child: Text(
                                            'Beskrivelse',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                          width: 500,
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            controller: descriptionInput,
                                            cursorColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            maxLines: 10,
                                            decoration: InputDecoration(
                                                focusColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                filled: true,
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                fillColor: Colors.grey[50],
                                                border: const OutlineInputBorder(),
                                                hintText: "Skriv en kort og god beskrivelse av produktet",
                                                hintStyle: TextStyle(color: Colors.grey[400])),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 25, 0, 10),
                                          child: Text(
                                            'Pris',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                          width: 80,
                                          child: TextFormField(
                                            controller: priceInput,
                                            cursorColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            maxLines: 10,
                                            decoration: InputDecoration(
                                              focusColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              filled: true,
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              fillColor: Colors.grey[50],
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText: "300",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400]),
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          standardNavigator(
                                              context, MyAccount());
                                        },
                                        child: const Text('Legg til bilde')),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                                activeColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                value: individualRent,
                                                onChanged: (value) {
                                                  setState(() {
                                                    individualRent = value!;
                                                  });
                                                }),
                                            const Text(
                                              'Utstyr kan leies individuelt',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                                activeColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                value: packagePrice,
                                                onChanged: (value) {
                                                  setState(() {
                                                    packagePrice = value!;
                                                  });
                                                }),
                                            const Text(
                                              'Pakkepris',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                                activeColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                value: oneDayPrice,
                                                onChanged: (value) {
                                                  setState(() {
                                                    oneDayPrice = value!;
                                                  });
                                                }),
                                            const Text(
                                              'Pris for en dag',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                                activeColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                value: oneWeekPrice,
                                                onChanged: (value) {
                                                  setState(() {
                                                    oneWeekPrice = value!;
                                                  });
                                                }),
                                            const Text(
                                              'Pris for en uke',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                        //new Listings(listingID: "custom id", title: , description: description, availableFrom: availableFrom, availableTo: availableTo, category: category, price: price, gear: gear)
                                        onPressed: () {
                                          Listings listing = new Listings(
                                              listingID: "",
                                              userID: FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              title: titleInput.text,
                                              description:
                                                  descriptionInput.text,
                                              category: categoryInput.text,
                                              price:
                                                  stringToInt(priceInput.text));
                                          FirestoreServices()
                                              .postListing(listing);
                                          print(listing.getDescription());
                                        },
                                        child: const Text('Publiser annonse')),
                                  ],
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: bottombar(),
                        )
                      ],
                    ),
                  ),
                )),
          )
        : LoginPage(
            warningMsg: 'listing',
          );
  }
}

int stringToInt(String price) {
  return int.parse(price);
}
