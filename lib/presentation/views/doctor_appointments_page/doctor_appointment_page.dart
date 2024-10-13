import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/data/repositories/firebase_features.dart';
import 'package:mental_health/presentation/bloc/doctor_appointments/doctor_appointments_bloc.dart';
import 'package:mental_health/presentation/bloc/doctor_appointments/doctor_appointments_bloc.dart';

import '../../widgets/custom_button.dart';

class DoctorAppointmentPage extends StatefulWidget {
  final String currentUserId;
  const DoctorAppointmentPage({super.key, required this.currentUserId});

  @override
  State<DoctorAppointmentPage> createState() => _DoctorAppointmentPageState();

}


class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {

  FirebaseFeatures firebaseFeatures = FirebaseFeatures();

  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<DoctorAppointmentsBloc>(context).add(GetAppointmentModels(currentUserId: widget.currentUserId));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text('Appointments',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<DoctorAppointmentsBloc, DoctorAppointmentsState>(
          builder: (context, state) {
            if(state is DoctorAppointmentsLoading){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Colors.deepPurple,
                      color: Colors.pink,
                    ),
                  ],
                ),
              );
            }
            if (state is DoctorAppointmentsLoaded){

              return ListView.builder(
                itemCount: state.appointmentModels.length,
                  itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Text('Patient Name:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Expanded(
                                  child: Text(state.appointmentModels[index].userCallingName.toString(),
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 3,),

                            Row(
                              children: [
                                Text('Date: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(state.appointmentModels[index].date.toString(),
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),


                            SizedBox(height: 3,),

                            Row(
                              children: [
                                Text('Time: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(state.appointmentModels[index].time.toString(),
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Text('Verification ID: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(state.appointmentModels[index].eventId.toString(),
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                              ],
                            ),

                            Row(
                              children: [
                                Text('Payment Status: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text('Paid',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 3,),
                                Icon(Icons.verified,color: Colors.green,),
                              ],
                            ),

                            SizedBox(height: 10,),
                            CustomButtonWidget(
                              onPressed:()async{
                                await firebaseFeatures.deleteEvent(state.appointmentModels[index].eventId.toString(), widget.currentUserId, state.appointmentModels[index].userId.toString());
                                BlocProvider.of<DoctorAppointmentsBloc>(context).add(GetAppointmentModels(currentUserId: widget.currentUserId));
                              },
                              text: 'Complete Session',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  });
            }
            else{
              return Container();
            }

          },
        ),
      ),
    );
  }
}
