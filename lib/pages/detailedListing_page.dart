import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/classes/listings.dart';
import 'package:utstyr/services/firestore_services.dart';
import 'package:utstyr/widgets.dart';
import 'package:utstyr/widgets/bottombar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";
import 'package:utstyr/widgets/renterInfo.dart';
import 'package:expandable/expandable.dart';

import '../services/auth_services.dart';

//final listingRef = FirebaseFirestore.instance.collection('listings');

class SingleListingPage extends StatefulWidget {
  final String listingId;
  SingleListingPage({
    Key? key,
    required this.listingId,
  }) : super(key: key);

  static const String id = 'SingleListingPage'; //Page identifier for navigation

  @override
  State<SingleListingPage> createState() => _SingleListingPageState();
}

class _SingleListingPageState extends State<SingleListingPage> {
  //@override
  double defaultHeight = 500;
  double contentHeight = 400;
  double totalWidth = 1000;
  int transactionPrice = 0;
  double smallpadding = 2;
  double bigpadding = 25;
  double defaultRadius = 20;
  Color lightGreen = Color.fromRGBO(143, 172, 120, 57);
  DateTime finalStart = DateTime.now();
  DateTime finalEnd = DateTime.now();
  CarouselController carouselController = CarouselController();
  int price = 0;
  //int transactionPrice = 400;
  Widget build(BuildContext context) {
    Map<String, bool> values = {
      'Splitboard - 450 kr': false,
      'Teleskopstaver - 50 kr ': false,
      'Feller - 50 kr': false,
      'Pakkepris - 500 kr': true,
    };
    var allListings = Provider.of<List<Listings>>(context);
    Listings listing =
        FirestoreServices().listingByID(allListings, widget.listingId);
    price = listing.price;
    if (transactionPrice == 0) {
      transactionPrice = price;
    }
    //List images = listing.getImages();

    return Material(
        child: utstyrScaffold(
            context,
            SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(smallpadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(smallpadding),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(defaultRadius),
                            color: Colors.white,
                          ),
                          width: totalWidth,
                          height: defaultHeight,
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.all(bigpadding),
                                child: Text(
                                  listing.getTitle(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CarouselSlider(
                                carouselController: carouselController,
                                options: CarouselOptions(height: contentHeight),
                                items: [
                                  Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/Dp2K3VwY9ag1E0JrwVAs%2Fsplitboard1.png?alt=media&token=e12700ed-a5e6-46b0-beae-6cd5dcfa54b0'),
                                  Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/Dp2K3VwY9ag1E0JrwVAs%2Fsplitboard2.png?alt=media&token=8349da52-cd6e-44a4-9e7a-ef81045b2c53'),
                                  Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/Dp2K3VwY9ag1E0JrwVAs%2Fsplitboard3.png?alt=media&token=48126bd0-5794-4eb7-921c-a38cf864bfa6'),
                                  Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/Dp2K3VwY9ag1E0JrwVAs%2Fsplitboard4.png?alt=media&token=6cd39d12-0d3f-43db-a75a-ccc8e8c4d7fd'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(bigpadding),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () {
                                    // Use the controller to change the current page
                                    carouselController.previousPage();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: lightGreen,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(bigpadding),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    // Use the controller to change the current page
                                    carouselController.nextPage();
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: lightGreen,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(smallpadding),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(defaultRadius),
                                    color: Colors.white,
                                  ),
                                  width: totalWidth * 0.75,
                                  height: contentHeight,
                                  child: Padding(
                                    padding: EdgeInsets.all(bigpadding),
                                    child: SingleChildScrollView(
                                        child: Text(
                                      listing.getDescription(),
                                      softWrap: true,
                                      textAlign: TextAlign.left,
                                      style:
                                          TextStyle(fontSize: 16, height: 1.6),
                                    )),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(smallpadding),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            defaultRadius),
                                        color: Colors.white,
                                      ),
                                      width: totalWidth * 0.275,
                                      height: defaultHeight * 0.5,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(bigpadding - 10),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Pris',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            ListView(
                                              shrinkWrap: true,
                                              children:
                                                  values.keys.map((String key) {
                                                return new CheckboxListTile(
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  activeColor: lightGreen,
                                                  title: Text(key),
                                                  value: values[key],
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      values[key] =
                                                          !values[key]!;
                                                      print(values);
                                                    });
                                                  },
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(smallpadding),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            defaultRadius),
                                        color: Colors.white,
                                      ),
                                      width: totalWidth * 0.475,
                                      height: defaultHeight * 0.5,
                                      child: Padding(
                                          padding:
                                              EdgeInsets.all(bigpadding - 10),
                                          child: FlutterMap(
                                            options: MapOptions(
                                              center:
                                                  LatLng(60.397076, 5.324383),
                                              zoom: 13.0,
                                            ),
                                            layers: [
                                              TileLayerOptions(
                                                  urlTemplate:
                                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                  subdomains: ['a', 'b', 'c']),
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(smallpadding),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(defaultRadius),
                                      color: Colors.white,
                                    ),
                                    width: totalWidth * 0.250,
                                    height: defaultHeight * 0.5,
                                    child: Padding(
                                      padding: EdgeInsets.all(bigpadding - 4),
                                      child: renterInfo('renter123'),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.all(smallpadding),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(defaultRadius),
                                    color: Colors.white,
                                  ),
                                  width: totalWidth * 0.250,
                                  height: contentHeight,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        child: SfDateRangePicker(
                                          onSelectionChanged:
                                              _onSelectionChanged,
                                          view: DateRangePickerView.month,
                                          monthViewSettings:
                                              DateRangePickerMonthViewSettings(
                                                  firstDayOfWeek: 1),
                                          selectionMode:
                                              DateRangePickerSelectionMode
                                                  .range,
                                        ),
                                      ),
                                      Text(
                                        _getPrice(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.all(bigpadding - 10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _sendRequest();
                                          },
                                          child: const Text('Send foresørsel'),
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                lightGreen, // Background color
                                            onPrimary: Colors
                                                .white, // Text Color (Foreground color)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      bottombar()
                    ],
                  )),
            )) //Scaffold
        );
  } //WidgetBuild

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    PickerDateRange ranges = args.value;
    DateTime start = ranges.startDate!;
    DateTime end = ranges.endDate!;
    finalStart = start;
    finalEnd = end;
    final int difference = daysBetween(start, end);
    setState(() {
      transactionPrice = getPriceFromRange(difference);
    });
  }

  int getPriceFromRange(int range) {
    if (range == 0) {
      return price;
    } else {
      return price * range;
    }
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  String _getPrice() {
    return '$transactionPrice kr';
  }

  void _sendRequest() {
    // TODO: implement your code here
    print(
        'Hi, i would like to rent this equipment from $finalStart to $finalEnd for a total of $transactionPrice kr.');
  }

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

int stringToInt(String price) {
  return int.parse(price);
}
