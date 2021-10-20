import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// ignore: camel_case_types
class OpportunityPost_Admin extends StatefulWidget {
  const OpportunityPost_Admin({Key? key}) : super(key: key);

  @override
  _OpportunityPost_AdminState createState() => _OpportunityPost_AdminState();
}

// ignore: camel_case_types
class _OpportunityPost_AdminState extends State<OpportunityPost_Admin> {
  late File _pickedImage;
  var isPicked = false;
  void _pickImage() async {
    ImagePicker imagePicker = new ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 800,
    );
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
      isPicked = true;
    });
  }

  TextEditingController titleController = TextEditingController();
  String title = '';
  TextEditingController descriptionController = TextEditingController();
  String description = '';
  TextEditingController eminentController = TextEditingController();
  String eminentSpeaker = '';
  TextEditingController linkController = TextEditingController();
  String link = '';

  String imageUrl = '';

  DateTime eventDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (newTime != null) {
      setState(() {
        time = newTime;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    eminentController.dispose();
    descriptionController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp),
        ),
        title: Text("Add Opportunity"),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                  onChanged: (text) {
                    setState(() {
                      title = text;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  maxLines: null,
                  minLines: 3,
                  onChanged: (text) {
                    setState(() {
                      description = text;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: eminentController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Eminent Speaker',
                  ),
                  onChanged: (text) {
                    setState(() {
                      eminentSpeaker = text;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: linkController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Link',
                  ),
                  onChanged: (text) {
                    setState(() {
                      link = text;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EventDate: ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMd().format(eventDate).toString(),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2100))
                            .then((value) {
                          setState(() {
                            eventDate = value as DateTime;
                          });
                          FocusScope.of(context).unfocus();
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Colors.blue,
                        ),
                        child: Text(
                          "Select",
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[900]),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EventTime: ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      time.format(context),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectTime();
                        });
                        // print(time);
                        FocusScope.of(context).unfocus();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Colors.blue,
                        ),
                        child: Text(
                          "Select",
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[900]),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                // DateRangePickerDialog(
                //     firstDate: DateTime(2021), lastDate: DateTime(2121)),

                Container(
                  child: Column(
                    children: [
                      Row(children: [
                        Text(
                          "Select Image",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(flex: 2),
                        GestureDetector(
                          onTap: () {
                            _pickImage();
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: Colors.blue,
                            ),
                            child: Text(
                              "Select",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[900]),
                            ),
                          ),
                        ),
                      ]),
                      Container(
                        child: isPicked
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: Image(
                                      image: FileImage(_pickedImage),
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.6,
                  height: 40,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (isPicked) {
                      var time =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      firebase_storage.Reference ref = firebase_storage
                          .FirebaseStorage.instance
                          .ref()
                          .child('Opportunity_images')
                          .child('$time');
                      await ref.putFile(_pickedImage);
                      imageUrl = await ref.getDownloadURL();
                    }

                    FirebaseFirestore.instance.collection('Opportunities').add({
                      'Title': title,
                      'createdAt': Timestamp.now(),
                      'Description': description,
                      'Eminent Speaker': eminentSpeaker,
                      'Link': link,
                      'Date': eventDate,
                      'Time': time.format(context).toString(),
                      'Image': imageUrl,
                      'Participants': 0,
                    }).then((value) {
                      var documentId = value.id;
                      FirebaseFirestore.instance
                          .collection('Opportunities')
                          .doc(documentId)
                          .update({
                        'id': documentId,
                      });
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Opportunity has been added successfully"),
                          // content: Text("T"),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text("Okay"),
                            ),
                          ],
                        ),
                      );
                      setState(() {
                        titleController.clear();
                        descriptionController.clear();
                        linkController.clear();
                        eminentController.clear();
                        eventDate = DateTime.now();
                        time = TimeOfDay.now();
                        isPicked = false;
                      });
                    });
                  },
                  color: Colors.indigoAccent[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    "Post Opportunity",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
