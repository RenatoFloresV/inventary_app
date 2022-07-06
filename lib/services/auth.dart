// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inventary_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth;
  GoogleSignInAccount? _googleUser;
  UserModel _userModel = UserModel();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  AuthStatus _status = AuthStatus.Uninitialized;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = AuthStatus.Unauthenticated;
    } else {
      DocumentSnapshot userSnap =
          await _db.collection('users').doc(firebaseUser.uid).get();
      _userModel = UserModel.fromFirestore(userSnap);

      _status = AuthStatus.Authenticated;
    }

    notifyListeners();
  }

  Future<User?> googleSignIn() async {
    _status = AuthStatus.Authenticating;
    notifyListeners();

    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      _googleUser = googleUser!;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );
      UserCredential authResult = await _auth.signInWithCredential(credential);
      User user = authResult.user!;
      await updateUserData(user);
    } catch (e) {
      _status = AuthStatus.Uninitialized;
      notifyListeners();
    }
    return null;
  }

  Future<UserModel?> signInWithCredentials(
      String email, String password) async {
    _status = AuthStatus.Authenticating;
    notifyListeners();

    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user!;
      await updateUserData(user);
      _status = AuthStatus.Authenticated;
      notifyListeners();
      return _userModel;
    } catch (e) {
      _status = AuthStatus.Uninitialized;
      notifyListeners();
      return null;
    }
  }

  Future<UserModel?> signUpWithCredentials(
      String email, String password) async {
    _status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user!;
      await updateUserData(user);
      _status = AuthStatus.Authenticated;
      notifyListeners();
      return _userModel;
    } catch (e) {
      _status = AuthStatus.Uninitialized;
      notifyListeners();
      return null;
    }
  }

  Future<DocumentSnapshot> updateUserData(User user) async {
    DocumentReference userRef = _db.collection('users').doc(user.uid);

    userRef.set({
      'uid': user.uid,
      'email': user.email,
      'lastSign': DateTime.now(),
      'photoURL': user.photoURL,
      'displayName': user.displayName ?? user.email?.split('@')[0],
    }, SetOptions(merge: true));

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  void signOut() {
    _auth.signOut();
    _status = AuthStatus.Unauthenticated;
    notifyListeners();
  }

  final GoogleSignIn googleSignInDesktop = GoogleSignIn();

  String? name;
  String? imageUrl;
  Future<String?> signInWithGoogleDesktop() async {
    // Initialize Firebase
    await Firebase.initializeApp();
    User? user;

    // The `GoogleAuthProvider` can only be used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await _auth.signInWithPopup(authProvider);

      user = userCredential.user;
    } catch (e) {
      print(e);
    }

    if (user != null) {
      name = user.displayName;
      imageUrl = user.photoURL;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
    }
    return user?.uid;
  }

  AuthStatus get status => _status;
  UserModel get user => _userModel;
  GoogleSignInAccount get googleUser => _googleUser!;
}
