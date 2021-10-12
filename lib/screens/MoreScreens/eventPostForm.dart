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
        title: Text("Add Event"),
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
                // DateRangePickerDialog(
                //     firstDate: DateTime(2021), lastDate: DateTime(2121)),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.6,
                  height: 40,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    FirebaseFirestore.instance.collection('Notifications').add({
                      'Title': title,
                      'createdAt': Timestamp.now(),
                      'Description': description,
                      'Eminent Speaker': eminentSpeaker,
                      'Link': link,
                      'Date': eventDate,
                      'Time': time.format(context).toString(),
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
                      setState(() {
                        titleController.clear();
                        descriptionController.clear();
                        linkController.clear();
                        eminentController.clear();
                        eventDate = DateTime.now();
                        time = TimeOfDay.now();
                      });
                    });
                  },
                  color: Colors.indigoAccent[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    "Post Event",
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
