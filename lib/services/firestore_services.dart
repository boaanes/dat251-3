import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/classes/listings.dart';
import 'package:tuple/tuple.dart';

class FirestoreServices {
  /*Future getListings() {
    FirebaseFirestore.instance
        .collection('listings')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        return doc.data()?.map((list) =>
            list.docs.map((doc) => Listings.fromFirestore(doc)).toList());
      });
    });
    throw {};
  }*/

  Stream<List<Listings>>? getListings() {
    var ref = FirebaseFirestore.instance.collection('listings');
    return ref.snapshots().map(
        (list) => list.docs.map((doc) => Listings.fromFirestore(doc)).toList());
  }

  List filterListings(List listings, String category, filter) {
    print(filter);
    if (filter != 'nofilter') {
      return listings
          .where((listing) =>
              listing.category.contains(category) &&
              listing.price <= int.parse(filter))
          .toList();
    } else {
      return listings
          .where((listing) => listing.category.contains(category))
          .toList();
    }
  }

  Listings listingByID(List<Listings> allListings, String listingId) {
    for (var i = 0; i < allListings.length; i++) {
      if (allListings[i].getLisitngID() == listingId) {
        return allListings[i];
      }
    }
    return Listings(
      listingID: 'listingID',
      title: 'title',
      description: 'description',
      category: 'category',
      price: 0,
      gear: ['gear', 'gear'],
    );
  }
}
