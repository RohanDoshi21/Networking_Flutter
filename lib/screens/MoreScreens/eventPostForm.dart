import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class EventPost_Admin extends StatefulWidget {
  const EventPost_Admin({Key? key}) : super(key: key);

  @override
  _EventPost_AdminState createState() => _EventPost_AdminState();
}

// ignore: camel_case_types
class _EventPost_AdminState extends State<EventPost_Admin> {
  TextEditingController titleController = TextEditingController();
  String title = '';
  TextEditingController descriptionController = TextEditingController();
  String description = '';
  TextEditingController eminentController = TextEditingController();
  String eminentSpeaker = '';
  TextEditingController linkController = TextEditingController();
  String link = '';

  DateTime eventDate = DateTime.now();
  TimeOfDay time = TimeOfDay(hour: 7, minute: 15);

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
          icon: Icon(
            Icons.arrow_back_ios_sharp
          ),
        ),
      ),
      body: Form(
        child: Column(
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
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 25,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.white,
                          Colors.grey,
                        ],
                      ),
                    ),
                    child: Text(
                      "Select",
                      style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                    ),
                  ),
                ),
              ],
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
                    print(time);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 25,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.white,
                          Colors.grey,
                        ],
                      ),
                    ),
                    child: Text(
                      "Select",
                      style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                    ),
                  ),
                ),
              ],
            ),
            // DateRangePickerDialog(
            //     firstDate: DateTime(2021), lastDate: DateTime(2121)),
            MaterialButton(
              minWidth: double.infinity,
              height: 30,
              onPressed: () {
                FirebaseFirestore.instance.collection('Notifications').add({
                  'Title': title,
                  'createdAt': Timestamp.now(),
                  'Description': description,
                  'Eminent Speaker': eminentSpeaker,
                  'Link': link,
                  'Date': eventDate,
                  'Time' : time.format(context).toString(),
                }).then((value) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Event has been added sucessfully"),
                      // content: Text("T"),
                      actions: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text("okay"),
                        ),
                      ],
                    ),
                  );
                  titleController.clear();
                  descriptionController.clear();
                  linkController.clear();
                  eminentController.clear();
                });
              },
              color: Colors.indigoAccent[400],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              child: Text(
                "Post Event",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
