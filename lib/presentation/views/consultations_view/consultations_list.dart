import 'package:flutter/material.dart';
import 'package:mental_health/data/repositories/firebase_features.dart';
import 'package:mental_health/data/repositories/shared_preferences.dart';
import 'package:mental_health/presentation/views/consultations_view/widgets/consultation_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/appointment_model.dart';

class ConsultationsList extends StatefulWidget {
  final String currentUserId;
  final VoidCallback onCancelButtonPressed;
  final List<AppointmentModel>appointmentModels;
  const ConsultationsList({Key? key, required this.appointmentModels, required this.onCancelButtonPressed, required this.currentUserId}) : super(key: key);

  @override
  State<ConsultationsList> createState() => _ConsultationsListState();
}

class _ConsultationsListState extends State<ConsultationsList> {

  FirebaseFeatures firebaseFeatures = FirebaseFeatures();
  SharedPreferencesRepo sharedPR = SharedPreferencesRepo();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.appointmentModels.length,
        itemBuilder: (context,index){
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(
                    children: [
                      Text('Dr. ${widget.appointmentModels[index].doctorName.toString()}',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      ),
                      Spacer(),
                      IconButton(onPressed: ()async{
                        await sharedPR.saveAppointmentToSharedPreferences(AppointmentModel(
                          date: widget.appointmentModels[index].date.toString(),
                            doctorId: widget.appointmentModels[index].doctorId.toString(),
                          doctorName: widget.appointmentModels[index].doctorName.toString(),
                          eventId: widget.appointmentModels[index].eventId.toString(),
                          time: widget.appointmentModels[index].time.toString(),
                          userCallingName: widget.appointmentModels[index].userCallingName.toString(),
                          userId: widget.appointmentModels[index].userId.toString(),
                        ));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Saved successfully!'),
                          ),
                        );

                        }, icon: Icon(Icons.save_alt),),
                    ],
                  ),

                  SizedBox(height: 6,),

                  Row(
                    children: [
                      Text('Date: ',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      Text(widget.appointmentModels[index].date.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                    ],
                  ),

                  Row(
                    children: [
                      Text('Time: ',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      Text(widget.appointmentModels[index].time.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                    ],
                  ),

                  Row(
                    children: [
                      Text('Verification ID: ',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      Text(widget.appointmentModels[index].eventId.toString(),
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),


                    ],
                  ),

                  Row(
                    children: [
                      Text('Payment Status: ',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      Text('Paid',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(width: 8,),

                      Icon(Icons.verified,color: Colors.green,),

                    ],
                  ),

                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Text('Identifying name: ${widget.appointmentModels[index].userCallingName}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                      TextButton(onPressed: ()async{
                        await firebaseFeatures.deleteEvent(
                            widget.appointmentModels[index].eventId.toString()
                            , widget.currentUserId, widget.appointmentModels[index].doctorId.toString());
                        widget.onCancelButtonPressed();
                      }, child: Text('Cancel Appointment',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      ),),
                    ],
                  ),




                ],
              ),
            ),
          );
        });
  }
}
