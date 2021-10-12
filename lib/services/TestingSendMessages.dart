import 'package:cloud_firestore/cloud_firestore.dart';

void sendMessage() async {
  FirebaseFirestore.instance.collection('Notifications').add({
    'Title': "This is the text title",
    'createdAt' : Timestamp.now(),
    'Desciption' : "This the description of event and what all the event contains and everything that is said about the event",
    'Eminent Speaker' : "Mr/Mrs. XYZ XYZ",
    'Link' : "URL",
    'Date-Time': Timestamp.now(),
  });
}