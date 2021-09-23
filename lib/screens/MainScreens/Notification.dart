import 'package:flutter/material.dart';

List notificationsSampleList = [
  [
    "Sample Notification",
    "We are glad to have have you here welcome to our app \n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letra",
    "30/08/2021",
    "18:50"
  ],
  ["PASC", "Upcoming SIG at 6 pm on 31/08/2021", "30/08/2021", "18:45"],
  ["PISB", "Upcoming SIG at 6 pm on 30/08/2021", "30/08/2021", "18:44"],
  ["PCSB", "Upcoming SIG at 6 pm on 30/08/2021", "30/08/2021", "18:44"],
  ["WEBDEV", "Upcoming SIG at 6 pm on 30/08/2021", "30/08/2021", "18:44"],
  ["UDEMY", "Upcoming SIG at 6 pm on 30/08/2021", "30/08/2021", "18:44"],
  ["COURSERA", "Upcoming SIG at 6 pm on 30/08/2021", "30/08/2021", "18:44"],
  ["CLASS", "Upcoming SIG at 6 pm on 30/08/2021", "30/08/2021", "18:44"],
];

// COMPLETEDTODO: Add a button to dismis the notification from the list!
//! Remove dismis    
//! add a read more!
//! Add a speaker and platform, link sessions
class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Text(
                "Notifications and Updates !",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 22,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notificationsSampleList.length,
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
                              notificationsSampleList[index][0],
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
                              notificationsSampleList[index][1],
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
                            "-" +
                                notificationsSampleList[index][2] +
                                " " +
                                notificationsSampleList[index][3],
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
                                "Dismis",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              width: MediaQuery.of(context).size.width * 0.8,
                            ),
                            onTap: () {
                              // print(notificationsSampleList[index]);
                              setState(() {
                                notificationsSampleList.removeAt(index);
                              });
                              // print(notificationsSampleList);
                            },
                          ),
                        ],
                      ),
                    ),
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
