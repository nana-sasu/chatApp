import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of auth & firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //GEMINI MODIFICATION****
  // List to store logged-in user emails
  //final List<String> _loggedInUserEmails = [];

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sign user in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //save user info if it doesn't exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      // Add the email to the list
      //_loggedInUserEmails.add(email);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      //create user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //save user info in a separate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      //GEMINI MODIFICATION****
      // Add the email to the list
      //_loggedInUserEmails.add(email);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //GEMINI MODIFICATION****
  // Get the current user's email
  // Stream<String?> get userStream {
  //   return _auth.authStateChanges().map((user) => user?.email);
  // }

  //GEMINI MODIFICATION****
  // Get the list of logged-in user emails
  //List<String> get loggedInUserEmails => _loggedInUserEmails;

  //errors
}
