import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycollegenetwork/services/postrequests.dart';
import 'package:mycollegenetwork/services/userDetails.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// ignore: must_be_immutable
class UpdateUserInfo extends StatefulWidget {
  @override
  _UpdateUserInfoState createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  late File _pickedImage;
  var isPicked = false;
  void _pickImage() async {
    ImagePicker imagePicker = new ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
      isPicked = true;
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async => false,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Text(
                            //   "Update User Info",
                            //   style: TextStyle(
                            //     fontSize: 30,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Text(
                              "Update the required details",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[50],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                        CircleAvatar(
                          radius: 40,
                          // ignore: unnecessary_null_comparison
                          backgroundImage: isPicked
                              ? FileImage(_pickedImage) as ImageProvider
                              : NetworkImage(
                                  UserDetials.profilePhotoUrl.toString()),
                        ),
                        TextButton.icon(
                          onPressed: _pickImage,
                          icon: Icon(Icons.upload),
                          label: Text("Choose Image from gallery"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "About Me",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      if (val!.length > 50) {
                                        return "Description cannot be that long";
                                      } else
                                        return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    initialValue:
                                        UserDetials.description.toString(),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                    onChanged: (value) {
                                      UserDetials.description = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Birthdate",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    validator: (val) {
                                      if (val![2] != "/" ||
                                          val[5] != "/" ||
                                          val.length != 10) {
                                        return "Syntax not correct (dd/mm/yyyy)";
                                      } else
                                        return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    initialValue:
                                        UserDetials.birthday.toString(),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                    onChanged: (value) {
                                      UserDetials.birthday = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                              Text(
                                "Clubs",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: UserDetials.clubList!.keys
                                      .map(
                                        (clubName) => CheckboxListTile(
                                          title: Text(clubName),
                                          value:
                                              UserDetials.clubList![clubName],
                                          onChanged: (bool? value) {
                                            setState(
                                              () {
                                                UserDetials
                                                        .clubList![clubName] =
                                                    value;
                                              },
                                            );
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            padding: EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                              ),
                            ),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  String uid = auth.currentUser!.uid.toString();
                                  firebase_storage.Reference ref =
                                      firebase_storage.FirebaseStorage.instance
                                          .ref()
                                          .child('User_Profile_Photos')
                                          .child(uid + '.jpg');
                                  await ref.putFile(_pickedImage);
                                  UserDetials.profilePhotoUrl =
                                      await ref.getDownloadURL();
                                  await updateUserDetails();
                                  Navigator.pop(context);
                                }
                              },
                              color: Colors.indigoAccent[400],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              child: Text(
                                "Next",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
