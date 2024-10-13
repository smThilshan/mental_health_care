import 'package:flutter/material.dart';
import 'package:mental_health/data/repositories/firebase_features.dart';
import 'package:mental_health/presentation/views/sign_in_page/sign_in_page.dart';

import '../../widgets/custom_button.dart';

class ProfileOptions extends StatefulWidget {
  const ProfileOptions({Key? key}) : super(key: key);

  @override
  State<ProfileOptions> createState() => _ProfileOptionsState();
}

class _ProfileOptionsState extends State<ProfileOptions> {
  FirebaseFeatures firebaseFeatures = FirebaseFeatures();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.bookmark_add_outlined,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Favourites',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.navigate_next)),
                  ],
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.payment,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Payments',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.navigate_next)),
                  ],
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),



          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.notifications_active,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Notification Settings',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.navigate_next)),
                  ],
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 0),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    IconButton(onPressed: ()async{
                      await firebaseFeatures.signOutUser();
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => SignInPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.0, 0.0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ),
                      );
                    }, icon:  Icon(
                      Icons.logout_outlined,
                      color: Colors.red,
                    ),),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),

                ],
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),



        ],
      ),
    );
  }
}
