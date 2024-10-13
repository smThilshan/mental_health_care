import 'package:flutter/material.dart';
import 'package:mental_health/presentation/views/book_appointment_page/book_appointment_page.dart';
import 'package:mental_health/presentation/widgets/custom_button.dart';

class ViewDoctorPage extends StatefulWidget {
  final String currentUserId;
  final String endUserId;
  final String endUserName;
  final String endUserEmail;
  final String endUserGender;
  final String special;
  const ViewDoctorPage({Key? key, required this.currentUserId, required this.endUserId, required this.endUserName, required this.endUserEmail, required this.endUserGender, required this.special}) : super(key: key);

  @override
  State<ViewDoctorPage> createState() => _ViewDoctorPageState();
}

class _ViewDoctorPageState extends State<ViewDoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('View Doctor',style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 24,
                    ),),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                       backgroundImage: widget.endUserGender=='male'?AssetImage('assets/images/doctor_man.jpg'):AssetImage('assets/images/doctor_girl.jpg'),
                      ),
                      SizedBox(height: 20,),

                      Text(widget.endUserName,style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),),
                      Text(widget.endUserEmail,style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),),

                      SizedBox(height: 30,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Education',style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('Bsc Hons in Psychology and Mentology in the physiology of the neurology.'
                                'I have a number of certifications for your proof.',style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 16,
                            ),),
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Experienece',style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('I have 5 years of experience in treating people.'
                                'I have a number of certifications for your proof.',style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),),
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Specialized in',style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(widget.special,style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                CustomButtonWidget(text: 'Book an appointment', onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => BookAppointmentPage(
                        special: widget.special,
                        endUserGender: widget.endUserGender,
                        endUserEmail: widget.endUserEmail,
                        endUserName: widget.endUserName,
                        endUserId: widget.endUserId,
                        currentUserId: widget.currentUserId,
                      ),
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
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
