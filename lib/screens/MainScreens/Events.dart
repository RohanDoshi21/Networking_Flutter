import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycollegenetwork/services/userDetails.dart';
import 'package:url_launcher/url_launcher.dart'; //Library for date formatter

//! add a read more!
//! Add a speaker and platform, link sessions
// String noOfParticipants = "0";

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  // Future _getParticipants(uid) async {
  //   FirebaseFirestore.instance
  //       .collection("Events")
  //       .doc(uid)
  //       .collection("UserDetails").get().then((_val) {
  //         setState(() {
  //           noOfParticipants = _val.docs.length.toString();
  //         });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Text(
                "Events",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 22,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Events')
                    .orderBy('Date', descending: true)
                    .snapshots(),
                builder: (ctx, AsyncSnapshot notificationsSnapshots) {
                  if (notificationsSnapshots.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final _notification = notificationsSnapshots.data!.docs;
                  return ListView.builder(
                    itemCount: _notification.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: // LinearGradient(colors: [Color(0xFF4b6cb7), Color(0xFF182848)])),
                              LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                // Color(0xFF12c2e9),
                                // Color(0xFF21096e),
                                Color(0xFF161D6F),
                                // Color(0xFF0A1931),
                                Color(0xFF150E56),
                                Color(0xFF0A043C),
                              ]),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text(
                                  _notification[index]['Title'],
                                  // "Title",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.8,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                child: Text(
                                  _notification[index]['Description'],
                                  // "Hi",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.8,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                // Code to format the date as received from firebase
                                // DateFormat.yMd()
                                //     .add_jm()
                                //     .format(_notification[index]['createdAt']
                                //         .toDate())
                                //     .toString(),
                                // "hello",
                                "Event on: " +
                                    DateFormat.yMd()
                                        .format(_notification[index]['Date']
                                            .toDate())
                                        .toString() +
                                    " at " +
                                    _notification[index]['Time'],
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              InkWell(
                                child: Container(
                                  child: Text(
                                    "Read More",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                ),
                                onTap: () async {
                                  // print("Hello");
                                  // FutureBuilder(
                                  //   future: _getParticipants(
                                  //       _notification[index]['id']),
                                  //   builder: (BuildContext context,
                                  //       AsyncSnapshot snapshot) {
                                  //     if (snapshot.hasData) {
                                  //       showDialog(
                                  //         context: context,
                                  //         builder: (context) {
                                  //           return _CustomBox(
                                  //               notification:
                                  //                   _notification[index]);
                                  //         },
                                  //       );
                                  //     }
                                  //     return CircularProgressIndicator();
                                  //   },
                                  // );
                                  // await _getParticipants(_notification[index]['id']);
                                  // await FirebaseFirestore.instance
                                  //     .collection("Events")
                                  //     .doc(_notification[index]['id'])
                                  //     .collection("UserDetails").get().then((_val) {
                                  //   setState(() {
                                  //     noOfParticipants = _val.docs.length.toString();
                                  //   });
                                  // });

                                  bool isRegistered = true;
                                  DocumentSnapshot ds = await FirebaseFirestore
                                      .instance
                                      .collection("Events")
                                      .doc(_notification[index]['id'])
                                      .collection("UserDetails")
                                      .doc(UserDetails.uid)
                                      .get();
                                  this.setState(() {
                                    isRegistered = ds.exists;
                                  });

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return _CustomBox(
                                        notification: _notification[index],
                                        isRegistered: isRegistered,
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomBox extends StatelessWidget {
  final notification;
  var isRegistered;
  _CustomBox({
    required this.notification,
    required this.isRegistered,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
          decoration: BoxDecoration(
            color: Color(0xFF150E56).withOpacity(0.98),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(color: Colors.black, offset: Offset(0.0, 16.0)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: notification['Image'].length > 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(imageUrl: notification['Image']),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      )
                    : null,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: deviceHeight * 0.02),
                alignment: Alignment.center,
                child: Text(
                  notification['Title'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Container(
                child: Text(
                  notification['Description'],
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                  child: (notification['Eminent Speaker'].length > 0)
                      ? Column(
                          children: [
                            Text(
                              "Eminent Speaker: " +
                                  notification['Eminent Speaker'],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        )
                      : null),
              // Container(
              //     child: (notification['Link'].length > 0)
              //         ? Column(
              //             children: [
              //               Text(
              //                 "Link: " + notification['Link'],
              //                 textAlign: TextAlign.start,
              //                 style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: 16,
              //               ),
              //             ],
              //           )
              //         : null),
              Container(
                  child: (notification['Date'] != null)
                      ? Text(
                          "Date: " +
                              DateFormat.yMMMMd()
                                  .format(notification['Date'].toDate())
                                  .toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      : null),
              Container(
                  child: notification['Time'] != null
                      ? Text(
                          "Time: " + notification['Time'],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      : null),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text("No of participants: " +
                    notification['Participants'].toString()),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: !isRegistered
                    ? GestureDetector(
                        onTap: () {
                          // print(UserDetails.uid);
                          FirebaseFirestore.instance
                              .collection('Events')
                              .doc(notification['id'])
                              .collection('UserDetails')
                              .doc(UserDetails.uid)
                              .set({
                            'Name': UserDetails.name,
                            'RollNo': UserDetails.rollNo,
                            'Email': UserDetails.email,
                            'PhoneNo': UserDetails.phoneNo,
                          });
                          FirebaseFirestore.instance
                              .collection('Events')
                              .doc(notification['id'])
                              .update(
                            {
                              'Participants': FieldValue.increment(1),
                            },
                          );
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: deviceHeight * 0.055,
                            width: deviceHeight * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.red,
                                    Colors.redAccent,
                                  ]),
                            ),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[900]),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          launchURL(notification['Link']);
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: deviceHeight * 0.055,
                            width: deviceHeight * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.blue,
                                    Colors.blueAccent,
                                  ]),
                            ),
                            child: Text(
                              "Go to Event!",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[900]),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void launchURL(_url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
