import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Utstyr', () {
    //Login screen
    final emailField = find.byValueKey('email');
    final passwordField = find.byValueKey('password');
    final confirmPasswordField = find.byValueKey('confirmPassword');
    final termsCheckbox = find.byValueKey('termsCheck');
    final signInButton = find.byValueKey('signIn');

    //Home screen
    final testField = find.byValueKey('testField');

    //Scaffold
    final loginNavButton = find.byValueKey('loginNavButton');
    final logOutNavButton = find.byValueKey('logOutNavButton');

    FlutterDriver? driver;

    Future<bool> isPresent(SerializableFinder byValueKey,
        {Duration timeout = const Duration(seconds: 1)}) async {
      try {
        await driver?.waitFor(byValueKey, timeout: timeout);
        return true;
      } catch (exception) {
        return false;
      }
    }

    setUpAll(() async {
      // ignore: unnecessary_null_in_if_null_operators
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      if (driver != null) {
        driver?.close();
      }
    });

    test('sign in', () async {
      //if (await isPresent(logOutNavButton)) {
      //  await driver!.tap(logOutNavButton);
      //}
      await driver?.tap(testField);
      await driver?.enterText('123123123');

      /*await driver!.tap(loginNavButton);
      await driver!.tap(emailField);
      await driver!.enterText('test123@gmail.com');

      await driver!.tap(passwordField);
      await driver!.enterText('123123123');

      await driver!.tap(confirmPasswordField);
      await driver!.enterText('123123123');

      await driver!.tap(termsCheckbox);

      await driver!.tap(signInButton);*/
    });
  });
}
