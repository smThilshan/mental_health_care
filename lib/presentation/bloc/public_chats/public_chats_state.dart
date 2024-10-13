part of 'public_chats_bloc.dart';

@immutable
abstract class PublicChatsState {}

class PublicChatsInitial extends PublicChatsState {}

class PublicChatsChatsLoading extends PublicChatsState{}

class PublicChatsLoaded extends PublicChatsState{
  final List<DoctorModel>doctorList;
  PublicChatsLoaded({required this.doctorList});
}