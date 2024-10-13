part of 'doctor_chats_bloc.dart';

@immutable
abstract class DoctorChatsEvent {}

class GetChatsEvent extends DoctorChatsEvent{
  final String currentUserId;
  GetChatsEvent({required this.currentUserId});
}
