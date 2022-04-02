import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/pages/home_page.dart';
import 'package:utstyr/services/auth_services.dart';
import 'package:utstyr/widgets/warningMessage.dart';
import '../widgets.dart';
import 'package:utstyr/services/auth_services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class LoginPage extends StatefulWidget {
  final String warningMsg;
  const LoginPage({Key? key, this.warningMsg = ''}) : super(key: key);
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
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _addressController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();

  String initialCountry = 'NO';
  PhoneNumber number = PhoneNumber(isoCode: 'NO');
  var _controller = TextEditingController();

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
                      (widget.warningMsg != '')
                          ? Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: warningMsg(widget.warningMsg),
                            )
                          : Container(),
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
                                                  key: const ValueKey("email"),
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
                                                      prefixIcon: const Icon(Icons.email),
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
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: TextFormField(
                                                validator: (value) {},
                                                controller:
                                                    _firstNameController,
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
                                                    prefixIcon: const Icon(Icons.person),
                                                    labelText: 'Fornavn',
                                                    border: const OutlineInputBorder(),
                                                    hintText: "Ola",
                                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: TextFormField(
                                                validator: (value) {},
                                                controller: _lastNameController,
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
                                                    prefixIcon: const Icon(Icons.person),
                                                    labelText: 'Etternavn',
                                                    border: const OutlineInputBorder(),
                                                    hintText: "Norman",
                                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child:
                                                  InternationalPhoneNumberInput(
                                                onInputChanged:
                                                    (PhoneNumber number1) {
                                                  number = number1;
                                                },
                                                onInputValidated: (bool value) {
                                                  print(value);
                                                },
                                                selectorConfig: SelectorConfig(
                                                  selectorType:
                                                      PhoneInputSelectorType
                                                          .DROPDOWN,
                                                ),
                                                ignoreBlank: false,
                                                autoValidateMode:
                                                    AutovalidateMode.disabled,
                                                selectorTextStyle: TextStyle(
                                                    color: Colors.black),
                                                initialValue: number,
                                                textFieldController:
                                                    _phoneController,
                                                formatInput: false,
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        signed: true,
                                                        decimal: true),
                                                inputDecoration: InputDecoration(
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
                                                    labelText: 'Telefonnummer',
                                                    border: const OutlineInputBorder(),
                                                    hintText: "76543210",
                                                    hintStyle: TextStyle(color: Colors.grey[400])),
                                                onSaved: (PhoneNumber number) {
                                                  print('On Saved: $number');
                                                },
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
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
                                                    prefixIcon: const Icon(Icons.email),
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
                                                key: const ValueKey('password'),
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
                                                key: const ValueKey(
                                                    'confirmPassword'),
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
                                                      key: const ValueKey(
                                                          'termsCheck'),
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
                                    key: const ValueKey("signIn"),
                                    onTap: onLogin
                                        ? () async {
                                            print(_emailController.text);
                                            print(_passwordController.text);
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
                                        : () async {
                                            await AuthenticateService()
                                                .createUserWithEmailAndPassword(
                                                    _emailController.text,
                                                    _passwordController.text)
                                                .then(
                                              (value) {
                                                if (value != null) {
                                                  AuthenticateService()
                                                      .registerUserDataFirstTime(
                                                          _firstNameController
                                                              .text,
                                                          _lastNameController
                                                              .text,
                                                          number.phoneNumber,
                                                          _emailController.text,
                                                          value.user.uid);
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
          );
  }
}
