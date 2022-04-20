import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
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
  @override
  int price = 500;
  int transactionPrice = 500;
  DateTime finalStart = DateTime.now();
  DateTime finalEnd = DateTime.now();
  CarouselController carouselController = CarouselController();
  Widget build(BuildContext context) {
    Map<String, bool> values = {
      'Splitboard - 450 kr': false,
      'Teleskopstaver - 50 kr ': false,
      'Feller - 50 kr': false,
      'Pakkepris - 500 kr': true,
    };
    var allListings = Provider.of<List<Listings>>(context);
    return Material(
        child: utstyrScaffold(
            context,
            SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          width: 1000,
                          height: 500,
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(25, 20, 15, 0),
                                child: Text(
                                  _getTitle(),
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
                                options: CarouselOptions(height: 400.0),
                                items: [
                                  Image.asset('assets/images/splitboard1.png'),
                                  Image.asset('assets/images/splitboard2.png'),
                                  Image.asset('assets/images/splitboard3.png'),
                                  Image.asset('assets/images/splitboard4.png'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () {
                                    // Use the controller to change the current page
                                    carouselController.previousPage();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Color.fromRGBO(143, 172, 120, 57),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    // Use the controller to change the current page
                                    carouselController.nextPage();
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color.fromRGBO(143, 172, 120, 57),
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
                                padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  width: 750,
                                  height: 400,
                                  child: Padding(
                                    padding: EdgeInsets.all(25),
                                    child: SingleChildScrollView(
                                        child: Text(
                                      _getDescription() + _getDescription(),
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
                                    padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      width: 275,
                                      height: 250,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 15, 15, 15),
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
                                                  activeColor: Color.fromRGBO(
                                                      143, 172, 120, 57),
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
                                    padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      width: 475,
                                      height: 250,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 25, 10, 10),
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
                                padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    width: 250,
                                    height: 250,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      child: renterInfo('renter123'),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  width: 250,
                                  height: 400,
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
                                            EdgeInsets.fromLTRB(10, 25, 10, 21),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _sendRequest();
                                          },
                                          child: const Text('Send foresørsel'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromRGBO(143, 172,
                                                120, 57), // Background color
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

  String _getTitle() {
    return "Toppturpakke - Splitboard";
  }

  String _getDescription() {
    return "Humpty Dumpty sat on a wall, Humpty Dumpty had a great fall, All the king's horses and all the king's men, Couldn't put Humpty together again, Humpty Dumpty sat on a wall, Humpty Dumpty had a great fall, \n All the king's horses and all the king's men, Couldn't put Humpty together again, Humpty Dumpty sat on a wall, Humpty Dumpty had a great fall, All the king's horses and all the king's men, Couldn't put Humpty together again. \n All the king's horses and all the king's men, Couldn't put Humpty together again, Humpty Dumpty sat on a wall, Humpty Dumpty had a great fall, All the king's horses and all the king's men, Couldn't put Humpty together again, \n All the king's horses and all the king's men, Couldn't put Humpty together again, Humpty Dumpty sat on a wall, Humpty Dumpty had a great fall, All the king's horses and all the king's men, Couldn't put Humpty together again";
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
