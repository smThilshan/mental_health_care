part of 'dashboard_view_bloc.dart';

@immutable
abstract class DashboardViewEvent {}

class SpecialistsClickEvent extends DashboardViewEvent{}
class ChatsClickEvent extends DashboardViewEvent{}
class ConsultationsClickEvent extends DashboardViewEvent{
  final String currentUserId;
  ConsultationsClickEvent({required this.currentUserId});
}

class ArticlesClickEvent extends DashboardViewEvent{}

class ProfileClickEvent extends DashboardViewEvent{
  final String currentUserId;
  ProfileClickEvent({required this.currentUserId});
}

class SignOutEvent extends DashboardViewEvent{}
