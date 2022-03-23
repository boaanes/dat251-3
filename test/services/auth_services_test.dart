import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utstyr/services/auth_services.dart';

void main() async {
  setUp(() {});
  tearDown(() {});

  test('sign in', () async {
    final auth = MockFirebaseAuth();
    final signin = AuthenticateService(auth: auth);
    final actual =
        await signin.signInWithEmailAndPassword("theodor@gmail.com", "123123");
    final match = await auth.signInWithEmailAndPassword(
        email: "theodor@gmail.com", password: "123123");

    expect(actual.user, match.user);
  });
}
