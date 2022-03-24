import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticateService {
  final FirebaseAuth? auth;
  AuthenticateService({this.auth});

  Stream<User?> get user => FirebaseAuth.instance.authStateChanges();

  Future createUserWithEmailAndPassword(email, password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signInWithEmailAndPassword(email, password) async {
    try {
      if (auth != null) {
        UserCredential? userCredential = await auth?.signInWithEmailAndPassword(
            email: email, password: password);
        return userCredential;
      } else {
        var currInstance = FirebaseAuth.instance;
        UserCredential userCredential = await currInstance
            .signInWithEmailAndPassword(email: email, password: password);
        return userCredential;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future registerUserDataFirstTime(firstName, lastName, phone, email, id) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.doc(id).set({
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'id': id,
      'rating': [],
      'ranking': 0,
      'listings': [],
    });
  }
}
