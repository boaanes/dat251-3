import 'package:flutter/material.dart';
import 'package:utstyr/widgets.dart';
import 'package:utstyr/widgets/bottombar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";

import '../services/auth_services.dart';

class SingleListingPage extends StatefulWidget {
  SingleListingPage({Key? key}) : super(key: key);
  static const String id = 'SingleListingPage'; //Page identifier for navigation

  @override
  State<SingleListingPage> createState() => _SingleListingPageState();
}

class _SingleListingPageState extends State<SingleListingPage> {
  @override
  int price = 500;
  CarouselController carouselController = CarouselController();
  Widget build(BuildContext context) {
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
                                    padding:
                                        EdgeInsets.fromLTRB(25, 25, 25, 25),
                                    child: Text(
                                      _getDescription(),
                                      textAlign: TextAlign.left,
                                      style:
                                          TextStyle(fontSize: 16, height: 1.6),
                                    ),
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
                                      child: Text(
                                        "Price here",
                                        textAlign: TextAlign.left,
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
                                  child: Text(
                                    "Renter info here",
                                    textAlign: TextAlign.center,
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
    // TODO: implement your code here
    print(args.value);

    price = 800;
  }

  String _getTitle() {
    return "Toppturpakke - Splitboard";
  }

  String _getDescription() {
    return "Humpty Dumpty sat on a wall, Humpty Dumpty had a great fall, All the king's horses and all the king's men, Couldn't put Humpty together again, Humpty Dumpty sat on a wall, Humpty Dumpty had a great fall, All the king's horses and all the king's men, Couldn't put Humpty together again, Humpty Dumpty sat on a wall, Humpty Dumpty had a great fall, All the king's horses and all the king's men, Couldn't put Humpty together again";
  }

  String _getPrice() {
    return '$price kr';
  }

  void _sendRequest() {
    // TODO: implement your code here
    print('Request to rent');
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
