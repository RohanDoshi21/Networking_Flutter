// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'MoreScreens/AppDrawer.dart';
import 'MainScreens/Calender.dart';
import 'MainScreens/Chats.dart';
import 'MainScreens/Home.dart';
import 'MainScreens/Notification.dart';
import 'MainScreens/Profile.dart';

class InitialPage extends StatefulWidget {
  const InitialPage();
  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _selectedIndex = 2;
  static const List<Widget> pages = <Widget>[
    Notifications(),
    Chats(),
    Home(),
    Calender(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    // _sendMessage();
    setState(() {
      _selectedIndex = index;
    });
  }

  // void initState() {
  //   condition();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("My College Network"),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifcations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Calender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

// void _sendMessage() async {
//   FirebaseFirestore.instance.collection('Notifications').add({
//     'Title': "This is the sample title",
//     'createdAt' : Timestamp.now(),
//     'Description' : "This the description of event and what all the event contains and everything that is said about the event",
//     'Eminent Speaker' : "Mr/Mrs. XYZ XYZ",
//     'Link' : "URL",
//      'Date-Time': "Not fixed right now",
//   });
// }