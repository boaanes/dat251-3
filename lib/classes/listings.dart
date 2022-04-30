import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';

class Listings {
  final String listingID;
  final String userID;
  final String title;
  final String description;
  final String category;
  final int price;

  Listings(
      {required this.listingID,
      required this.userID,
      required this.title,
      required this.description,
      required this.category,
      required this.price});


  factory Listings.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data()! as Map;
    return Listings(
        listingID: doc.id,
        userID: data['userID'] ?? 'userID',
        title: data['title'] ?? 'Title',
        description: data['description'] ?? 'Description',
        category: data['category'] ?? 'Category',
        price: data['price'] ?? 'Price');
  }

  String getLisitngID() {
    return listingID;
  }

  String getTitle() {
    return title;
  }

  String getDescription() {
    return description;
  }

  int getPrice() {
    return price;
  }
}
