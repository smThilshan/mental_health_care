import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/presentation/bloc/saved_appointments/saved_appointments_bloc.dart';

class SavedAppointmentsPage extends StatefulWidget {
  const SavedAppointmentsPage({super.key});

  @override
  State<SavedAppointmentsPage> createState() => _SavedAppointmentsPageState();
}

class _SavedAppointmentsPageState extends State<SavedAppointmentsPage> {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<SavedAppointmentsBloc>(context).add(GetSavedAppointments());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Saved Appointments',style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<SavedAppointmentsBloc, SavedAppointmentsState>(
        builder: (context, state) {
          if(state is SavedAppointmentsLoading){
            return CircularProgressIndicator();
          }
          else if(state is SavedAppointmentsSuccess){
            return ListView.builder(
                itemCount: state.appointmentModels.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Dr. ${state.appointmentModels[index].doctorName.toString()}',
                            style: TextStyle(color: Colors.green,
                            fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            ),

                            Text('Time: ${state.appointmentModels[index].time.toString()}',
                              style: TextStyle(color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text('Date: ${state.appointmentModels[index].date.toString()}',
                              style: TextStyle(color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text('Session ID: ${state.appointmentModels[index].eventId.toString()}',
                              style: TextStyle(color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text('Appointment For: ${state.appointmentModels[index].userCallingName.toString()}',
                              style: TextStyle(color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Row(
                              children: [
                                Spacer(),
                                IconButton(onPressed: ()async{
                                  BlocProvider.of<SavedAppointmentsBloc>(context).add(DeleteSavedAppointment(eventId: state.appointmentModels[index].eventId.toString()));
                                }, icon: Icon(Icons.delete,color: Colors.red,)),
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          else if(state is SavedAppointmentsEmpty){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.no_backpack_outlined,color: Colors.black,),
                  Text('There are no saved appointments.')
                ],
              ),
            );
          }
          else{
            return Container();
          }

        },
      ),
    );
  }
}
