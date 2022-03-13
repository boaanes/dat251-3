import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/pages/home_page.dart';
import 'package:utstyr/services/auth_services.dart';
import '../widgets.dart';
import 'package:utstyr/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _regKey = GlobalKey<FormState>();
  bool onLogin = true;
  bool acceptTerms = false;
  var _phoneController = TextEditingController();
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _addressController = TextEditingController();
  var _postCodeController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    bool loggedIn = user != null;

    return loggedIn
        ? Home()
        : utstyrScaffold(
            context,
            SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 0,
                            0), //Padding fra kanten av hvit boks til kant av skjerm
                        child: Container(
                            width: 500,
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, //Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  30.0), //Padding fra ting i hvit boks til kant i hvit boks
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: Text(
                                      onLogin ? 'Innlogging' : 'Registrering',
                                      style: TextStyle(
                                          fontSize: 27,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ),
                                  AnimatedCrossFade(
                                      firstChild: Form(
                                          key: _loginKey,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: TextFormField(
                                                  validator: (value) {},
                                                  controller: _emailController,
                                                  cursorColor: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  decoration: InputDecoration(
                                                      focusColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary,
                                                      filled: true,
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 2,
                                                              color: Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary),
                                                          borderRadius:
                                                              BorderRadius.circular(10)),
                                                      fillColor: Colors.grey[50],
                                                      prefixIcon: const Icon(Icons.phone),
                                                      labelText: 'E-post',
                                                      border: const OutlineInputBorder(),
                                                      hintText: "hei@utstyr.no",
                                                      hintStyle: TextStyle(color: Colors.grey[400])),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: TextFormField(
                                                  obscureText: true,
                                                  validator: (value) {},
                                                  controller:
                                                      _passwordController,
                                                  cursorColor: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  decoration: InputDecoration(
                                                      focusColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary,
                                                      filled: true,
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 2,
                                                              color: Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary),
                                                          borderRadius:
                                                              BorderRadius.circular(10)),
                                                      fillColor: Colors.grey[50],
                                                      prefixIcon: const Icon(Icons.password),
                                                      labelText: 'Passord',
                                                      border: const OutlineInputBorder(),
                                                      hintText: "Passord",
                                                      hintStyle: TextStyle(color: Colors.grey[400])),
                                                ),
                                              ),
                                            ],
                                          )),
                                      secondChild: Form(
                                        key: _regKey,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: TextFormField(
                                                validator: (value) {},
                                                controller: _emailController,
                                                cursorColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                decoration: InputDecoration(
                                                    focusColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                    filled: true,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Theme.of(context)
                                                                    .colorScheme
                                                                    .secondary),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 2,
                                                            color:
                                                                Theme.of(context)
                                                                    .colorScheme
                                                                    .secondary),
                                                        borderRadius:
                                                            BorderRadius.circular(10)),
                                                    fillColor: Colors.grey[50],
                                                    prefixIcon: const Icon(Icons.phone),
                                                    labelText: 'E-post',
                                                    border: const OutlineInputBorder(),
                                                    hintText: "hei@utstyr.no",
                                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: TextFormField(
                                                obscureText: true,
                                                validator: (value) {},
                                                controller: _passwordController,
                                                cursorColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                decoration: InputDecoration(
                                                    focusColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                    filled: true,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Theme.of(context)
                                                                    .colorScheme
                                                                    .secondary),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 2,
                                                            color:
                                                                Theme.of(context)
                                                                    .colorScheme
                                                                    .secondary),
                                                        borderRadius:
                                                            BorderRadius.circular(10)),
                                                    fillColor: Colors.grey[50],
                                                    prefixIcon: const Icon(Icons.password),
                                                    labelText: 'Passord',
                                                    border: const OutlineInputBorder(),
                                                    hintText: "Passord",
                                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: TextFormField(
                                                obscureText: true,
                                                validator: (value) {},
                                                controller:
                                                    _confirmPasswordController,
                                                cursorColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                decoration: InputDecoration(
                                                    focusColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                    filled: true,
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Theme.of(context)
                                                                    .colorScheme
                                                                    .secondary),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 2,
                                                            color:
                                                                Theme.of(context)
                                                                    .colorScheme
                                                                    .secondary),
                                                        borderRadius:
                                                            BorderRadius.circular(10)),
                                                    fillColor: Colors.grey[50],
                                                    prefixIcon: const Icon(Icons.password),
                                                    labelText: 'Bekreft passord',
                                                    border: const OutlineInputBorder(),
                                                    hintText: "Bekreft passord",
                                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                      activeColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                      value: acceptTerms,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          acceptTerms = value!;
                                                        });
                                                      }),
                                                  const Text(
                                                    'Jeg har lest og godtatt brukervilkår',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      crossFadeState: onLogin
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      duration:
                                          const Duration(milliseconds: 300)),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  //Text('emailMessage'),
                                  InkWell(
                                    onTap: onLogin
                                        ? () async {
                                            await AuthenticateService()
                                                .signInWithEmailAndPassword(
                                                    _emailController.text,
                                                    _passwordController.text)
                                                .then(
                                              (value) {
                                                if (value != null) {
                                                  _emailController.clear();
                                                  _passwordController.clear();
                                                }
                                              },
                                            );
                                          }
                                        : () {
                                            AuthenticateService()
                                                .createUserWithEmailAndPassword(
                                                    _emailController.text,
                                                    _passwordController.text)
                                                .then(
                                              (value) {
                                                if (value != null) {
                                                  _emailController.clear();
                                                  _passwordController.clear();
                                                  _confirmPasswordController
                                                      .clear();
                                                }
                                              },
                                            );
                                          },
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: onLogin
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : acceptTerms
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : Colors.grey),
                                      child: Center(
                                        child: Text(
                                          onLogin ? "Logg inn" : 'Fortsett',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Center(
                                      child: InkWell(
                                        onTap: onLogin
                                            ? () {
                                                setState(() {
                                                  onLogin = false;
                                                });
                                              }
                                            : () {
                                                setState(() {
                                                  onLogin = true;
                                                });
                                              },
                                        child: Container(
                                          child: Text(
                                            onLogin
                                                ? 'Har du ikke bruker?'
                                                : 'Allerede registrert deg?',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      SizedBox(height: 20),

                      //New column
                    ],
                  ),
                ),
              ),
            ),
            /* Column(
              children: [
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        AuthenticateService().signInWithEmailAndPassword(
                            'theodornorill@gmail.com', 'Friluft1234');
                      },
                      child: const Text('Knapp for å logge inn')),
                ),
              ],
            ),*/
          );
  }
}
