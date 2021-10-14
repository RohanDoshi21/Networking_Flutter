import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //Library for date formattor

//! add a read more!
//! Add a speaker and platform, link sessions

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
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
                    .collection('Notifications')
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
                                // Code to format the date as recieved from firebase
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
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return _CustomBox(
                                          notification: _notification[index]);
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
  _CustomBox({
    required this.notification,
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
                      ? Text(
                          "Eminent Speaker: " + notification['Eminent Speaker'],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      : null),
              SizedBox(
                height: 16,
              ),
              Container(
                  child: (notification['Link'].length > 0)
                      ? Text(
                          "Link: " + notification['Link'],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      : null),
              SizedBox(
                height: 16,
              ),
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
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: deviceHeight * 0.055,
                    width: deviceHeight * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.white,
                            Colors.grey,
                          ]),
                    ),
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 18, color: Colors.grey[900]),
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
