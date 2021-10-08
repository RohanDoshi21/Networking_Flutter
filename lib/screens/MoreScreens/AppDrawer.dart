import 'package:flutter/material.dart';
import 'package:mycollegenetwork/services/authentication.dart';
import 'package:mycollegenetwork/services/userDetails.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth auth = FirebaseAuth.instance;
    // String uid = auth.currentUser!.uid.toString();
    // String email = auth.currentUser!.email.toString();
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Row(
                    children: [
                      InkWell(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                UserDetials.profilePhotoUrl.toString()),
                            backgroundColor: Colors.amber[50],
                          ),
                          onTap: () {}),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // GetUserName(uid, 18),
                            Text(
                              UserDetials.name.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              UserDetials.email.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.login_sharp),
              title: Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                AuthenticationHelper().signOut(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text(
                'About Us',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text(
                'Visit Website',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.laptop),
              title: Text(
                'Developers',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}