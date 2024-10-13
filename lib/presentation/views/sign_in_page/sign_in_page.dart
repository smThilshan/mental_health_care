import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/data/repositories/firebase_features.dart';
import 'package:mental_health/presentation/views/dashboard_view/dashboard_view.dart';
import 'package:mental_health/presentation/views/doctor_dashboard/doctor_dashboard.dart';
import 'package:mental_health/presentation/views/saved_appointments_page/saved_appointments_page.dart';
import 'package:mental_health/presentation/views/signup_page/signup_page.dart';
import 'package:mental_health/presentation/widgets/custom_button.dart';
import 'package:mental_health/presentation/widgets/custom_text_field.dart';

import '../../bloc/signin_page/signin_page_bloc.dart';
import '../../widgets/image_icon_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailText = TextEditingController();
  TextEditingController pwdText = TextEditingController();
  FirebaseFeatures firebaseFeatures = FirebaseFeatures();

  bool isDoc=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdfcfc),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        Spacer(),
                        IconButton(onPressed: (){
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => SavedAppointmentsPage(),
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
                        }, icon: Icon(Icons.bookmark_add,))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        hint: 'Email', textEditingController: emailText),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        hint: 'Password', textEditingController: pwdText),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDoc?Colors.orange:Colors.lightGreenAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                        ),
                        onPressed: (){
                          if (isDoc==false) {
                            setState(() {
                              isDoc=true;
                              isDoc=isDoc;
                              print(isDoc);
                            });
                          }
                          else{
                            setState(() {
                              isDoc=false;
                              isDoc=isDoc;
                              print(isDoc);
                            });
                          }
                        }, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(isDoc?Icons.accessibility:Icons.volunteer_activism_rounded,color: Colors.black,),
                        SizedBox(width: 10,),
                        Text(isDoc?'Public':'Psychologist',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ],
                    )),
                    SizedBox(height: 20,),
                    CustomButtonWidget(
                      text: 'Sign in',
                      onPressed: () async {
                        if (isDoc==true) {
                          User user = await firebaseFeatures.signInUser(
                              emailText.text, pwdText.text);
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                  DashboardView(user: user),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
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
                        }
                        else{
                          User user = await firebaseFeatures.signInDoctor(
                              emailText.text, pwdText.text);
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                  DoctorDashboard(user: user),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
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
                        }

                      },
                    ),



                    SizedBox(height: 100,),

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[
                        ImageIconButton(
                          imagePath: 'assets/images/google_black.png',
                        ),
                        ImageIconButton(
                          imagePath: 'assets/images/apple.png',
                        ),
                        ImageIconButton(
                          imagePath: 'assets/images/facebook_black.png',
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SignUpPage(),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
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
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
