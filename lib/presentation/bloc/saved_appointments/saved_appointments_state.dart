part of 'saved_appointments_bloc.dart';

@immutable
abstract class SavedAppointmentsState {}

class SavedAppointmentsInitial extends SavedAppointmentsState {}

class SavedAppointmentsLoading extends SavedAppointmentsState {}

class SavedAppointmentsSuccess extends SavedAppointmentsState {
  final List<AppointmentModel>appointmentModels;
  SavedAppointmentsSuccess({required this.appointmentModels});
}

class SavedAppointmentsEmpty extends SavedAppointmentsState {}
