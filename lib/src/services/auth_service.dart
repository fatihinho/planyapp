import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  String get userUID => _auth.currentUser!.uid;

  bool get hasCurrentUser => _auth.currentUser != null ? true : false;

  Future<bool> signInAnonymous() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInAnonymously()
        .catchError((e) => throw e.toString());
    final User? user = userCredential.user;
    if (user != null) {
      return true;
    }
    return false;
  }
}
