import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycollegenetwork/services/userDetails.dart';

Future<void> updateUserDetails() async {
    final CollectionReference usercollection =
        FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    usercollection
        .doc(uid)
        .update({
          "Description": UserDetails.description,
          "Birthday": UserDetails.birthday,
          "ClubList" : UserDetails.clubList,
          "ProfilePhotoUrl" : UserDetails.profilePhotoUrl,
          "ClubNo" : UserDetails.noOfClubs,
        })
        .then((value) => print("User Details updated"))
        .catchError((error) => print("Failed to update user: $error"));
    return;
}