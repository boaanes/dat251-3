import 'package:cloud_firestore/cloud_firestore.dart';

class Listings {
  final String title;
  final String description;
  final DateTime availableFrom;
  final DateTime availableTo;
  final String category;
  final String price;
  final List gear;

  Listings(
      {required this.title,
      required this.description,
      required this.availableFrom,
      required this.availableTo,
      required this.category,
      required this.price,
      required this.gear});

  factory Listings.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data()! as Map;
    return Listings(
      title: data['title'] ?? 'Title',
      description: data['description'] ?? 'Description',
      availableFrom: data['availableFrom'].toDate() ?? DateTime.now(),
      availableTo: data['availableTo'].toDate() ?? DateTime.now(),
      category: data['category'] ?? 'Category',
      price: data['price'] ?? 'Price',
      gear: data['gear'] ?? 'Gear',
    );
  }
}
