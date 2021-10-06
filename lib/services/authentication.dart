import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mycollegenetwork/screens/Login+Registration/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';

Map<String, bool?>? clubListTemp = {
    'PASC': false,
    'PISB': false,
    'CSI': false,
    'EDC': false,
    'DEBSOC': false,
    'MUN' : false,
  };
class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut(context) async {
    await _auth.signOut();
    print('signout');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (route) => false);
  }

  //ADD USER INFO
  Future<void> storeUserDetails(name, rollNo, phoneNo) async {
    final CollectionReference usercollection =
        FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    String email = auth.currentUser!.email.toString();
    usercollection
        .doc(uid)
        .set({
          "Name": name,
          "RollNo": rollNo,
          "PhoneNo": "+91" + phoneNo,
          "Email": email,
          "Description": "Hello I am " + name,
          "ClubNo": 0,
          "EventNo": 0,
          "ProfilePhotoUrl": "https://freesvg.org/img/abstract-user-flat-4.png",
          "Birthday": "01/01/2000",
          "ClubList" : clubListTemp,
        }, SetOptions(merge: true))
        .then((value) => print("User Details Added"))
        .catchError((error) => print("Failed to add user: $error"));

    User? user = auth.currentUser;
    user!.linkWithPhoneNumber(phoneNo);

    return;
  }

  Future signInWithGoogle() async {
    late final isuser;
    try {
      // ignore: unused_local_variable
      UserCredential userCredential;
      if (kIsWeb) {
        var googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;
        final googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);
        isuser = userCredential.additionalUserInfo!.isNewUser;
      }
      return isuser;
    } catch (e) {
      return e;
    }
  }

  Future microsoftSignIn(String provider, List<String> scopes,
      Map<String, String> parameters) async {
    bool isNewUser = false;
    User? user;
    try {
      user = await FirebaseAuthOAuth()
          .openSignInFlow(provider, scopes, parameters);
      String lastSignInTime = user!.metadata.lastSignInTime.toString();
      String creationTime = user.metadata.creationTime.toString();
      lastSignInTime = lastSignInTime.substring(0, lastSignInTime.length - 7);
      creationTime = creationTime.substring(0, creationTime.length - 7);
      // print(lastSignInTime);
      if (lastSignInTime == creationTime) {
        isNewUser = true;
      }
      return isNewUser;
    } on PlatformException catch (error) {
      return error;
    }
  }
}
