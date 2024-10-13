part of 'saved_appointments_bloc.dart';

@immutable
abstract class SavedAppointmentsEvent {}

class GetSavedAppointments extends SavedAppointmentsEvent{}
class DeleteSavedAppointment extends SavedAppointmentsEvent{
  final String eventId;
  DeleteSavedAppointment({required this.eventId});
}