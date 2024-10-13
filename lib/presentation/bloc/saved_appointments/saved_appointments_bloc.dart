import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/data/models/appointment_model.dart';
import 'package:mental_health/data/repositories/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'saved_appointments_event.dart';
part 'saved_appointments_state.dart';

class SavedAppointmentsBloc extends Bloc<SavedAppointmentsEvent, SavedAppointmentsState> {
  SavedAppointmentsBloc() : super(SavedAppointmentsInitial()) {
    SharedPreferencesRepo spr = SharedPreferencesRepo();

    on<GetSavedAppointments>((event, emit) async{
      emit(SavedAppointmentsLoading());
      List<AppointmentModel> appointmentModels;
      appointmentModels = await spr.getAllAppointmentsFromSharedPreferences();
      emit(SavedAppointmentsSuccess(
        appointmentModels: appointmentModels,
      ));
    });

    on<DeleteSavedAppointment>((event, emit) async{
      emit(SavedAppointmentsLoading());
      await spr.deleteAppointmentFromSharedPreferences(event.eventId);
      List<AppointmentModel> appointmentModels;
      appointmentModels = await spr.getAllAppointmentsFromSharedPreferences();
      if(appointmentModels.isEmpty){
        emit(SavedAppointmentsEmpty());
      }
      else{
        emit(SavedAppointmentsSuccess(
          appointmentModels: appointmentModels,
        ));
      }

    });


  }
}
