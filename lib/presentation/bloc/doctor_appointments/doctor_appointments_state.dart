part of 'doctor_appointments_bloc.dart';

@immutable
abstract class DoctorAppointmentsState {}

class DoctorAppointmentsInitial extends DoctorAppointmentsState {}

class DoctorAppointmentsLoading extends DoctorAppointmentsState {}

class DoctorAppointmentsLoaded extends DoctorAppointmentsState {
  final List<AppointmentModel>appointmentModels;
  DoctorAppointmentsLoaded({required this.appointmentModels});
}

class DoctorAppointmentsFailed extends DoctorAppointmentsState {

}