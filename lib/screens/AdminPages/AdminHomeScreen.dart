import 'package:flutter/material.dart';
import 'package:mycollegenetwork/screens/AdminPages/eventPostForm.dart';

import 'opportunityPostForm.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Home Page"),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // This is for event
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventPost_Admin(),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Image(
                        image: AssetImage('assets/icons/EventIcon.png'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Add an Event",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                margin: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.amber[600],
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent,
                      offset: const Offset(
                        2.50,
                        2.50,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
              ),
            ),

            //This is for opportunity
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpportunityPost_Admin(),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Image(
                        image: AssetImage('assets/icons/EventIcon.png'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Add an Opportunity",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                margin: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.amber[600],
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent,
                      offset: const Offset(
                        2.50,
                        2.50,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), 
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
