import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/classes/listings.dart';
import 'package:utstyr/pages/detailedListing_page.dart';
import 'package:utstyr/services/firestore_services.dart';
import 'package:utstyr/widgets/standardNavigator.dart';

import '../widgets/bottombar.dart';
import '../widgets/scaffold.dart';

class ListingPage extends StatefulWidget {
  final String category;
  const ListingPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  String filter = 'nofilter';
  int maksPris = 99999999;
  var maksController = TextEditingController();
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  @override
  Widget build(BuildContext context) {
    var iconNames = {
      'snowboard': Icons.snowboarding,
      'topptur': Icons.nordic_walking,
      'alpint': Icons.downhill_skiing,
      'sykkel': Icons.pedal_bike,
      'camping': Icons.map
    };
    var allListings = Provider.of<List<Listings>>(context);
    return Material(
      child: utstyrScaffold(
          context,
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          width: 80,
                          height: 70,
                          child: Icon(
                            iconNames[widget.category],
                            size: 35,
                            color: Color(0xff2C4C16),
                          ),
                        ),
                      ),
                      Text(
                        capitalize(widget.category),
                        style: TextStyle(fontSize: 21),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 10, 0),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                filter = maksPris.toString();
                              });
                            },
                            child: Text('Filter')),
                      ),
                      (filter == 'nofilter')
                          ? Container()
                          : Container(
                              width: 150,
                              child: TextFormField(
                                controller: maksController,
                                decoration: InputDecoration(
                                  labelText: 'Maks pris',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                      (filter == 'nofilter')
                          ? Container()
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  filter = maksController.text;
                                });
                              },
                              child: Text('Søk')),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      children: FirestoreServices()
                          .filterListings(allListings, widget.category, filter)
                          .map((el) => Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: InkWell(
                                  onTap: () {
                                    standardNavigator(
                                        context,
                                        SingleListingPage(
                                          listingId: el.listingID,
                                        ));
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
                                                    el.title,
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                  Text(
                                                    '', // +
                                                    // testList[0]['størrelse'],
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                _getPrice(el),
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                              child: FirestoreServices()
                                                  .getImage(el))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList()),
                ),
                bottombar()
              ],
            ),
          )),
    );
  }

  List testList = [
    {
      'title': 'Splitboard utstyr',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    },
    {
      'title': 'Randonee utstyr2',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    },
    {
      'title': 'Alpint utstyr3',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    },
    {
      'title': 'Splitboard utstyr',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    },
    {
      'title': 'Randonee utstyr2',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    },
    {
      'title': 'Alpint utstyr3',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    },
    {
      'title': 'Splitboard utstyr',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    },
    {
      'title': 'Randonee utstyr2',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    },
    {
      'title': 'Alpint utstyr3',
      'price': '100kr - 400kr',
      'størrelse': 'EU 43 - 155cm'
    }
  ];

  _getPrice(el) {
    int price = el.price;
    return '$price kr';
  }
}
