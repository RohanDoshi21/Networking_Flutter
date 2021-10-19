import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycollegenetwork/screens/InitialPage.dart';
import 'package:mycollegenetwork/services/userDetails.dart';

// ignore: must_be_immutable
class GetUserData extends StatelessWidget {
  late String documentId;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    documentId = uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          UserDetails.name = data['Name'].toString();
          UserDetails.phoneNo = data['PhoneNo'].toString();
          UserDetails.email = data['Email'].toString();
          UserDetails.description = data['Description'].toString();
          UserDetails.rollNo = data['RollNo'].toString();
          UserDetails.noOfClubs = data['ClubNo'].toInt();
          UserDetails.noOfEvents = data['EventNo'].toInt();
          UserDetails.profilePhotoUrl = data['ProfilePhotoUrl'].toString();
          UserDetails.birthday = data['Birthday'].toDate();
          UserDetails.clubList = Map<String, bool?>.from(data['ClubList']);
          UserDetails.isAdmin = data['IsAdmin'];
          UserDetails.uid = data['Uid'];
          return InitialPage();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

// class GetData {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   get user => _auth.currentUser;
//   Future getUserData() async {
//     final CollectionReference usercollection =
//         FirebaseFirestore.instance.collection('Users');
//     FirebaseAuth auth = FirebaseAuth.instance;
//     String uid = auth.currentUser!.uid.toString();
//     return usercollection
//         .doc(uid)
//         .get()
//         .then((value) => print("User Details Added"))
//         .catchError((error) => print("Failed to add user: $error"));
//   }
// }