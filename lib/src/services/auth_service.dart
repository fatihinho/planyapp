import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

String get userUID => _auth.currentUser!.uid;

Future<bool> signInAnonymous() async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    final User? user = userCredential.user;
    if (user != null) {
      return true;
    }
  } catch (e) {
    print(e);
  }
  return false;
}

bool hasCurrentUser() {
  if (_auth.currentUser != null) {
    return true;
  } else {
    return false;
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
