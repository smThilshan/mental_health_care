import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/data/repositories/firebase_features.dart';
import 'package:mental_health/presentation/views/doctor_chats_page/doctor_chats_page.dart';
import 'package:mental_health/presentation/views/doctor_dashboard/widgets/options_button_template.dart';
import 'package:mental_health/presentation/views/sign_in_page/sign_in_page.dart';
import 'package:mental_health/presentation/widgets/custom_button.dart';

import '../doctor_appointments_page/doctor_appointment_page.dart';

class DoctorDashboard extends StatefulWidget {
  final User user;
  const DoctorDashboard({Key? key, required this.user}) : super(key: key);

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  FirebaseFeatures firebaseFeatures = FirebaseFeatures();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
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

                    }, icon: Icon(Icons.logout_outlined,color: Colors.red,)),
                    Spacer(),
                    Text('Hey Doc!',style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),),
                    Spacer(),
                    IconButton(onPressed: (){}, icon: Icon(Icons.person_2_outlined)),
                  ],
                ),

                SizedBox(height: 10,),

                Text("What's the plan today?",style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     // CustomButtonWidget(text: 'View Profile', onPressed: (){}),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          OptionsButtonTemplate(
                            optionName: 'Chats',
                            icon: Icons.chat,
                            onPressed: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => DoctorChatsPage(user: widget.user),
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
                            },
                          ),
                          OptionsButtonTemplate(
                            optionName: 'Appointments',
                            icon: Icons.check_box,
                            onPressed: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => DoctorAppointmentPage(currentUserId: widget.user.uid),
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
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          OptionsButtonTemplate(
                            optionName: 'Consultations',
                            icon: Icons.calendar_month,
                            onPressed: (){},
                          ),
                          OptionsButtonTemplate(
                            optionName: 'Payments',
                            icon: Icons.payment,
                            onPressed: (){},
                          ),
                        ],
                      ),
                    ],
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
