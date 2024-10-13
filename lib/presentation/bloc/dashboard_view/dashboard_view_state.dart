part of 'dashboard_view_bloc.dart';

@immutable
abstract class DashboardViewState {}

class DashboardViewInitial extends DashboardViewState {}

class SpecialistPageState extends DashboardViewState{
  final List<DoctorModel>docModels;
  SpecialistPageState({required this.docModels});
}
class ChatsPageState extends DashboardViewState{}
class ConsultationsPageState extends DashboardViewState{
  final List<AppointmentModel>appointmentModels;
  ConsultationsPageState({required this.appointmentModels});
}

class ArticlesPageState extends DashboardViewState{
  final List<ArticleModel> articleModels;
  ArticlesPageState({required this.articleModels});
}

class ProfilePageState extends DashboardViewState{
  final UserModel userModel;
  ProfilePageState({required this.userModel});
}
class DashboardLoadingState extends DashboardViewState{}
