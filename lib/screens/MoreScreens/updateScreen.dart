import 'dart:io';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycollegenetwork/services/getrequests.dart';
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
      imageQuality: 75,
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
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          child: Container(
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
                                UserDetails.profilePhotoUrl.toString()),
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
                                      UserDetails.description.toString(),
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
                                    UserDetails.description = value;
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                            // Column(
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Birthdate:  ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMMd()
                                      .format(UserDetails.birthday as DateTime)
                                      .toString(),
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
                                            initialDate: UserDetails.birthday
                                                as DateTime,
                                            firstDate: DateTime(1995),
                                            lastDate: DateTime.now())
                                        .then((value) {
                                      setState(() {
                                        UserDetails.birthday = value;
                                      });
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
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Clubs",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Column(
                              children: UserDetails.clubList!.keys
                                  .map(
                                    (clubName) => CheckboxListTile(
                                      title: Text(clubName),
                                      value: UserDetails.clubList![clubName],
                                      onChanged: (bool? value) {
                                        setState(
                                          () {
                                            UserDetails.clubList![clubName] =
                                                value;
                                          },
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
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
                              if (isPicked) {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                String uid = auth.currentUser!.uid.toString();
                                firebase_storage.Reference ref =
                                    firebase_storage.FirebaseStorage.instance
                                        .ref()
                                        .child('User_Profile_Photos')
                                        .child(uid + '.jpg');
                                await ref.putFile(_pickedImage);
                                UserDetails.profilePhotoUrl =
                                    await ref.getDownloadURL();
                              }
                              if (_formKey.currentState!.validate()) {
                                UserDetails.noOfClubs = 0;
                                UserDetails.clubList!.forEach((key, value) {
                                  if (value == true) {
                                    UserDetails.noOfClubs =
                                        (UserDetails.noOfClubs! + 1);
                                  }
                                });
                                await updateUserDetails();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GetUserData(),
                                  ),
                                );
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
    );
  }
}
