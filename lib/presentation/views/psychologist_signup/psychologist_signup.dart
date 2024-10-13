import 'package:flutter/material.dart';

import '../../../data/repositories/firebase_features.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class PsychologistSignup extends StatefulWidget {
  const PsychologistSignup({Key? key}) : super(key: key);

  @override
  State<PsychologistSignup> createState() => _PsychologistSignupState();
}

class _PsychologistSignupState extends State<PsychologistSignup> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  FirebaseFeatures firebaseFeatures = FirebaseFeatures();
  String selectedOption = 'General';
  String gender = 'male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Create an account',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    '#Psychologist',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'As a psychologist, you can get appointments to treat patients, counsel them for them to lead a better life and to spread love',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      hint: 'name', textEditingController: nameTextController),
                  CustomTextField(
                      hint: 'email',
                      textEditingController: emailTextController),
                  CustomTextField(
                      hint: 'Password',
                      textEditingController: passwordTextController),
                  CustomTextField(
                      hint: 'Confirm Password',
                      textEditingController: confirmPasswordTextController),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Gender',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  DropdownButton<String>(
                    value: gender,
                    onChanged: (String? value) {
                      setState(() {
                        gender = value!; // Update the selected value
                        print(value);
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text('Female'),
                      ),
                    ],
                  ),
                  Text(
                    'What are you specialized in?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  DropdownButton<String>(
                    value: selectedOption,
                    onChanged: (String? value) {
                      setState(() {
                        selectedOption = value!; // Update the selected value
                        print(value);
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'General',
                        child: Text('General'),
                      ),
                      DropdownMenuItem(
                        value: 'Gestalt',
                        child: Text('Gestalt'),
                      ),
                      DropdownMenuItem(
                        value: 'Counsellor',
                        child: Text('Counsellor'),
                      ),
                      DropdownMenuItem(
                        value: 'Coaching',
                        child: Text('Coaching'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButtonWidget(text: 'Submit Proofs', onPressed: () {}),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButtonWidget(
                      text: 'SignUp',
                      onPressed: () async {
                        if (nameTextController.text.isNotEmpty &&
                            passwordTextController.text.isNotEmpty &&
                            confirmPasswordTextController.text.isNotEmpty &&
                            emailTextController.text.isNotEmpty) {
                          await firebaseFeatures
                              .registerDoctorWithEmailAndPassword(
                                  nameTextController.text,
                                  emailTextController.text,
                                  passwordTextController.text,
                                  confirmPasswordTextController.text,
                                  selectedOption,
                            gender,
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
