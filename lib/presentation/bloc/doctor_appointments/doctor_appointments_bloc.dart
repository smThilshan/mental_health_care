import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/data/data_sources/firebase_firestore.dart';
import 'package:mental_health/data/models/appointment_model.dart';
import 'package:meta/meta.dart';

part 'doctor_appointments_event.dart';
part 'doctor_appointments_state.dart';

class DoctorAppointmentsBloc extends Bloc<DoctorAppointmentsEvent, DoctorAppointmentsState> {
  DoctorAppointmentsBloc() : super(DoctorAppointmentsInitial()) {
    FirestoreDataSource firestoreDataSource = FirestoreDataSource();
    on<GetAppointmentModels>((event, emit) async{
     emit(DoctorAppointmentsLoading());
     List<AppointmentModel> appointmentModels;
     appointmentModels=await firestoreDataSource.fetchAppointments(event.currentUserId);
     emit(DoctorAppointmentsLoaded(appointmentModels: appointmentModels));
    });
    
  }
}
