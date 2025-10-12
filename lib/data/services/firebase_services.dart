import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Google Sign-In
  Future<bool> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        log("Login Success: ${user.email}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
      return false;
    }
  }


  Future<void> signOut() async {
    try {

      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
        log("Google account signed out");
      }

      await _auth.signOut();
      log("Firebase user signed out");
    } catch (e) {
      print("SignOut Error: $e");
    }
  }
}
