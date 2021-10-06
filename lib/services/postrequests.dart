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
          "Description": UserDetials.description,
          "Birthday": UserDetials.birthday,
          "ClubList" : UserDetials.clubList,
        })
        .then((value) => print("User Details Added"))
        .catchError((error) => print("Failed to add user: $error"));
    return;
}