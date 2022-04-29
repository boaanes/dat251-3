import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/classes/listings.dart';
import 'package:utstyr/pages/home_page.dart';
import 'package:utstyr/pages/login_page.dart';
import 'package:utstyr/services/firestore_services.dart';
import 'config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          initialData: null,
          value: FirebaseAuth.instance.authStateChanges(),
        ),
        StreamProvider<List<Listings>>.value(
          initialData: [
            Listings(
              listingID: 'listingID',
              title: 'title',
              description: 'description',
              category: 'category',
              price: 1,
              gear: ['gear'],
            ),
            Listings(
              listingID: 'listingID',
              title: 'title',
              description: 'description',
              category: 'category',
              price: 1,
              gear: ['gear'],
            ),
            Listings(
              listingID: 'listingID',
              title: 'title',
              description: 'description',
              category: 'category',
              price: 1,
              gear: ['gear'],
            ),
            Listings(
              listingID: 'listingID',
              title: 'title',
              description: 'description',
              category: 'category',
              price: 1,
              gear: ['gear'],
            ),
            Listings(
              listingID: 'listingID',
              title: 'title',
              description: 'description',
              category: 'category',
              price: 1,
              gear: ['gear'],
            )
          ],
          value: FirestoreServices().getListings(),
        )
      ],
      child: MaterialApp(
          title: 'Utstyr',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xff2C4C16),
              secondary: const Color(0xffA9BE98),
            ),
          ),
          home: Home(),
          routes: {
            Home.id: ((context) => Home()),
            LoginPage.id: ((context) => LoginPage())
          }),
    );
  }
}
