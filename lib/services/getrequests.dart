import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

late String phoneNumber;
class GetData {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  Future getUserData() async {
    final CollectionReference usercollection =
        FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    return usercollection
        .doc(uid)
        .get()
        .then((value) => print("User Details Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  final double fontsize;
  GetUserName(this.documentId, this.fontsize);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            "Something went wrong",
            style: TextStyle(fontSize: fontsize, color: Colors.white),
          );
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text(
            "Document does not exist",
            style: TextStyle(fontSize: fontsize, color: Colors.white),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            "${data['Name']}",
            style: TextStyle(fontSize: fontsize, color: Colors.white),
          );
        }
        return Text(
          "loading",
          style: TextStyle(fontSize: fontsize, color: Colors.white),
        );
      },
    );
  }
}

class GetUserRollNo extends StatelessWidget {
  final String documentId;

  final double fontsize;
  GetUserRollNo(this.documentId, this.fontsize);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            "Something went wrong",
            style: TextStyle(fontSize: fontsize, color: Colors.white),
          );
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text(
            "Document does not exist",
            style: TextStyle(fontSize: fontsize, color: Colors.white),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            "${data['RollNo']}",
            style: TextStyle(fontSize: fontsize, color: Colors.white),
          );
        }
        return Text(
          "loading",
          style: TextStyle(fontSize: fontsize, color: Colors.white),
        );
      },
    );
  }
}

class GetUserPhoneNo extends StatelessWidget {
  final String documentId;
  final double fontsize;
  GetUserPhoneNo(this.documentId, this.fontsize);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            "Something went wrong",
            style: TextStyle(fontSize: fontsize, color: Colors.white),
          );
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text(
            "Document does not exist",
            style: TextStyle(fontSize: fontsize, color: Colors.white),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          phoneNumber = data['PhoneNo'].toString();
          return Text(
            "${data['PhoneNo']}",
            style: TextStyle(fontSize: fontsize, color: Colors.white),
          );
        }
        return Text(
          "loading",
          style: TextStyle(fontSize: fontsize, color: Colors.white),
        );
      },
    );
  }
}
