part of 'doctor_appointments_bloc.dart';

@immutable
abstract class DoctorAppointmentsEvent {}

class GetAppointmentModels extends DoctorAppointmentsEvent {
  final String currentUserId;
  GetAppointmentModels({required this.currentUserId});
}
