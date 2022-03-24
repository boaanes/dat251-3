import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/pages/login_page.dart';
import 'package:utstyr/widgets/bottombar.dart';
import 'package:utstyr/widgets/scaffold.dart';

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
                                            validator: (value) {},
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
                                            'Beskrivelse',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                          width: 500,
                                          child: TextFormField(
                                            validator: (value) {},
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
                                      children: [
                                        Text("Valg"),
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
