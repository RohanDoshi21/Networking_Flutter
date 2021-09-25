import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycollegenetwork/services/getrequests.dart';
import 'package:url_launcher/url_launcher.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String uid = auth.currentUser!.uid.toString();
String email = auth.currentUser!.email.toString();
List clubDummtList = [
  "PASC",
  "PISB",
  "PCSB",
  "EDC",
];

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Ink(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://i0.wp.com/iot.do/wp-content/uploads/sites/2/2016/03/10152610_750630574969118_2154222791899229104_n.jpg?w=851&ssl=1"),
                          fit: BoxFit.none),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.grey.shade300,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: CircleAvatar(
                              radius: 42,
                              backgroundImage: NetworkImage(
                                  "https://freesvg.org/img/abstract-user-flat-4.png"),
                            ),
                          ),
                        ),
                        GetUserName(uid, 25),
                      ],
                    ),
                  ),

                  // ? will add later if required to do so
                  // MaterialButton(
                  //   color: Colors.black,
                  //   shape: CircleBorder(),
                  //   elevation: 0,
                  //   child: Icon(Icons.edit),
                  //   onPressed: () {},
                  // ),
                ],
              ),

              const SizedBox(height: 10.0),

              UserInfoProfile(),
              // TODO: add button type tiles for the clubs!
              // Container(
              //   height: 100.0,
              //   child: ListView.builder(
              //       itemCount: clubDummtList.length,
              //       itemBuilder: (context, index) {
              //         return Container(
              //           height: 20,
              //           width: double.infinity,
              //           child: Text(clubDummtList[index]),
              //         );
              //       }),
              // ),
            ],
          ),
        ));
  }
}

class UserInfoProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading:
                                Icon(Icons.sentiment_satisfied_alt_outlined),
                            title: Text("About Me"),
                            subtitle: Text(
                                "This is just short description about the person we can include all the thing things\nAchievements\nRating etc"),
                          ),
                          ListTile(
                            leading: Icon(Icons.push_pin_outlined),
                            title: Text("Roll No"),
                            subtitle: GetUserRollNo(uid, 13),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("Email"),
                            subtitle: Text(email),
                          ),
                          ListTile(
                            leading: IconButton(
                              onPressed: () => {
                                launch('tel:+91 ' + phoneNumber),
                              },
                              icon: Icon(Icons.phone),
                            ),
                            title: Text("Phone"),
                            subtitle: GetUserPhoneNo(uid, 13),
                            trailing: IconButton(
                              onPressed: () => {
                                launch('whatsapp://send?phone=' + phoneNumber),
                              },
                              icon: Icon(Icons.whatshot_rounded),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.cake),
                            title: Text("Birthday"),
                            subtitle: Text("21/06/2000"),
                          ),
                          ListTile(
                            leading: Icon(Icons.local_play),
                            title: Text("No of Clubs"),
                            subtitle: Text("2"),
                          ),
                          ListTile(
                            leading: Icon(Icons.star),
                            title: Text("No of Events participated!"),
                            subtitle: Text("8"),
                          ),
                          // ListTile(
                          //   leading: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       Icon(Icons.widgets),
                          //       Icon(Icons.window_sharp),
                          //       Icon(Icons.yard),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Clubs",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.widgets, size: 40),
                      SizedBox(width: 5),
                      Icon(Icons.window_sharp, size: 40),
                      SizedBox(width: 5),
                      Icon(Icons.yard, size: 40),
                      SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
