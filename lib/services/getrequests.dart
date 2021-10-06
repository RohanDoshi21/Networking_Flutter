import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
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
          UserDetials.name = data['Name'].toString();
          UserDetials.phoneNo = data['PhoneNo'].toString();
          UserDetials.email = data['Email'].toString();
          UserDetials.description = data['Description'].toString();
          UserDetials.rollNo = data['RollNo'].toString();
          UserDetials.noOfClubs = data['ClubNo'].toInt();
          UserDetials.noOfEvents = data['EventNo'].toInt();
          UserDetials.profilePhotoUrl = data['ProfilePhotoUrl'].toString();
          UserDetials.birthday = data['Birthday'].toString();
          // UserDetials.clubList = data['ClubList'];
          print(data['ClubList'].runtimeType);
          // json.decode(json.encode(internalLinkedHashMap)) as Map<String, dynamic>;
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