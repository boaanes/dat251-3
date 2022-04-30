import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:utstyr/pages/messages_page.dart';
import 'package:utstyr/services/firestore_services.dart';
import 'package:utstyr/widgets/standardNavigator.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

Widget renterInfo(String renterid) {
  Future getUserInfo(String userId) async {
    var userInfo =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userInfo.data();
  }

  void _handlePressed(types.User renterid, BuildContext context) async {
    final room = await FirebaseChatCore.instance.createRoom(renterid);
    standardNavigator(context, RoomsPage());
    // Navigate to the Chat screen
  }

  return FutureBuilder(
      future: getUserInfo(renterid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Utleier',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(143, 172, 120, 57)),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            snapshot.data['firstName'] +
                                ' ' +
                                snapshot.data['lastName'],
                            style: TextStyle(
                              fontSize: 18,
                              height: 2,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 15, 0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person_outline_rounded,
                          color: Color.fromRGBO(143, 172, 120, 57),
                          size: 80,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Erfaren Utleier',
                    style: TextStyle(
                      fontSize: 16,
                      height: 2,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Bergen, Hordaland',
                    style: TextStyle(
                      fontSize: 16,
                      height: 2,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Svarer vanligvis innen få minutter',
                    style: TextStyle(
                      fontSize: 14,
                      height: 2,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 11),
                  child: ElevatedButton(
                    onPressed: () {
                      _handlePressed(types.User(id: renterid), context);
                    },
                    child: const Text('Send melding'),
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromRGBO(143, 172, 120, 57), // Background color
                      onPrimary: Colors.white, // Text Color (Foreground color)
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      });
}
