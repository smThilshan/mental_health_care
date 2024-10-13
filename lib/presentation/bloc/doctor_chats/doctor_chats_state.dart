part of 'doctor_chats_bloc.dart';

@immutable
abstract class DoctorChatsState {}

class DoctorChatsInitial extends DoctorChatsState {}

class DoctorChatsLoading extends DoctorChatsState{}

class DoctorChatsLoaded extends DoctorChatsState{
  final List<UserModel>userList;
  DoctorChatsLoaded({required this.userList});
}