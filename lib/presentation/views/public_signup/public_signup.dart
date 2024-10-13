import 'package:flutter/material.dart';
import 'package:mental_health/data/repositories/firebase_features.dart';
import 'package:mental_health/presentation/widgets/custom_button.dart';
import 'package:mental_health/presentation/widgets/custom_text_field.dart';

class PublicSignupPage extends StatefulWidget {
  const PublicSignupPage({Key? key}) : super(key: key);

  @override
  State<PublicSignupPage> createState() => _PublicSignupPageState();
}

class _PublicSignupPageState extends State<PublicSignupPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  FirebaseFeatures firebaseFeatures = FirebaseFeatures();
  String gender = 'male';

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
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
                  '#Public',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'When you have a public account, you can talk to psychologists and get assistance from them for a better healthy life :)',
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
                    hint: 'email', textEditingController: emailTextController),
                CustomTextField(
                    hint: 'Password',
                    textEditingController: passwordTextController),
                CustomTextField(
                    hint: 'Confirm Password',
                    textEditingController: confirmPasswordTextController),

                SizedBox(height: 20,),

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

                SizedBox(
                  height: 60,
                ),
                CustomButtonWidget(
                    text: 'SignUp',
                    onPressed: () async {
                      if (nameTextController.text.isNotEmpty &&
                          passwordTextController.text.isNotEmpty &&
                          confirmPasswordTextController.text.isNotEmpty &&
                          emailTextController.text.isNotEmpty) {
                        await firebaseFeatures
                            .registerPublicUserWithEmailAndPassword(
                                nameTextController.text,
                                emailTextController.text,
                                passwordTextController.text,
                                confirmPasswordTextController.text,
                        gender,
                        );
                      } else {
                        print('fill all fields');
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
