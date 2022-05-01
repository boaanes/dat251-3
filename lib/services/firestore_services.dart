import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
    return new Listings(
        listingID: 'listingID',
        userID: 'u1234',
        title: 'title',
        description: 'description',
        category: 'category',
        price: 0);
  }

  Future<void> postListing(Listings listing) async {
    var ref = FirebaseFirestore.instance.collection('listings');
    await ref.add({
      'userID': listing.userID,
      'title': listing.title,
      'category': listing.category,
      'description': listing.description,
      'price': listing.price
    });
  }

  Future<String> getImagesByID(String id) async {
    var ref = FirebaseStorage.instance.ref(id);
    return ref.child('splitboard1.png').getDownloadURL();
  }

  getImages(Listings listing) {
    if (listing.listingID == 'Dp2K3VwY9ag1E0JrwVAs') {
      return [
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/Dp2K3VwY9ag1E0JrwVAs%2Fsplitboard1.png?alt=media&token=e12700ed-a5e6-46b0-beae-6cd5dcfa54b0'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/Dp2K3VwY9ag1E0JrwVAs%2Fsplitboard2.png?alt=media&token=8349da52-cd6e-44a4-9e7a-ef81045b2c53'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/Dp2K3VwY9ag1E0JrwVAs%2Fsplitboard3.png?alt=media&token=48126bd0-5794-4eb7-921c-a38cf864bfa6'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/Dp2K3VwY9ag1E0JrwVAs%2Fsplitboard4.png?alt=media&token=6cd39d12-0d3f-43db-a75a-ccc8e8c4d7fd'),
      ];
    } else if (listing.listingID == 'OHqhVHarsDw3pOUbnssL') {
      return [
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/1xOB45IQTZSrATQl3DAI%2F659_1242976620.jpg?alt=media&token=572ef9f6-9e13-4a63-8405-db96e40728ad'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/1xOB45IQTZSrATQl3DAI%2F659_1780214521.jpg?alt=media&token=965e28b5-401c-4ae3-b616-cfcc7c1e7e90'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/1xOB45IQTZSrATQl3DAI%2F659_1838192688.jpg?alt=media&token=45e331f6-f90b-4d12-b730-8c148fe3dc7e'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/1xOB45IQTZSrATQl3DAI%2F659_322048889.jpg?alt=media&token=6f3c338d-83ce-4fa0-a4cf-70b81d443a73'),
      ];
    } else if (listing.listingID == 'e06a0bdd-2fee-4232-810c-26746bcaa163') {
      return [
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/e06a0bdd-2fee-4232-810c-26746bcaa16%2Fsykkel1.jpg?alt=media&token=defb58e5-8632-440a-8329-865227412c72'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/e06a0bdd-2fee-4232-810c-26746bcaa16%2Fsykkel2.jpg?alt=media&token=28c364cf-37c6-4d35-adcd-871af977ef71'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/e06a0bdd-2fee-4232-810c-26746bcaa16%2Fsykkel3.jpg?alt=media&token=d709b193-59fd-4875-af7b-0d01ff3daa84'),
      ];
    } else if (listing.listingID == 'lB81f4rWaDheK4jsJZn6') {
      return [
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/lB81f4rWaDheK4jsJZn6%2Frandonee1.jpg?alt=media&token=5d4eaef9-84e6-43ac-9830-5a9353adb1b3'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/lB81f4rWaDheK4jsJZn6%2Frandonee2.jpg?alt=media&token=97235dda-a559-48b6-8e32-b69ce1da374d'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/lB81f4rWaDheK4jsJZn6%2Frandonee3.jpg?alt=media&token=e9c21c4a-1c75-4d56-90eb-099f3f0c8474'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/lB81f4rWaDheK4jsJZn6%2Frandonee4.jpg?alt=media&token=f83d2b1c-3396-4d96-9f1a-0eb5efff63ca'),
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/lB81f4rWaDheK4jsJZn6%2Frandonee5.jpg?alt=media&token=e5837103-9524-46ab-b486-ba26cf248caa')
      ];
    } else {
      return [
        Image.network(
            'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/noImage%2FNo_image_available.jpg?alt=media&token=f4b8ff24-053a-4a57-9ec2-7bf4ca030c2f'),
      ];
    }
  }

  getImage(Listings listing) {
    if (listing.listingID == 'Dp2K3VwY9ag1E0JrwVAs') {
      return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/Dp2K3VwY9ag1E0JrwVAs%2Fsplitboard1.png?alt=media&token=e12700ed-a5e6-46b0-beae-6cd5dcfa54b0');
    } else if (listing.listingID == 'OHqhVHarsDw3pOUbnssL') {
      return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/1xOB45IQTZSrATQl3DAI%2F659_1242976620.jpg?alt=media&token=572ef9f6-9e13-4a63-8405-db96e40728ad');
    } else if (listing.listingID == 'e06a0bdd-2fee-4232-810c-26746bcaa163') {
      return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/e06a0bdd-2fee-4232-810c-26746bcaa16%2Fsykkel1.jpg?alt=media&token=defb58e5-8632-440a-8329-865227412c72');
    } else if (listing.listingID == 'lB81f4rWaDheK4jsJZn6') {
      return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/lB81f4rWaDheK4jsJZn6%2Frandonee1.jpg?alt=media&token=5d4eaef9-84e6-43ac-9830-5a9353adb1b3');
    } else {
      return Image.network(
          'https://firebasestorage.googleapis.com/v0/b/dat251-3.appspot.com/o/noImage%2FNo_image_available.jpg?alt=media&token=f4b8ff24-053a-4a57-9ec2-7bf4ca030c2f');
    }
  }
}
