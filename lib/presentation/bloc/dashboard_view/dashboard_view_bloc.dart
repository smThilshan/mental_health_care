import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/data/data_sources/firebase_firestore.dart';
import 'package:mental_health/data/data_sources/news_api.dart';
import 'package:mental_health/data/models/appointment_model.dart';
import 'package:meta/meta.dart';

import '../../../data/models/doctor_model.dart';
import '../../../data/models/news_response_model.dart';
import '../../../data/models/user_model.dart';

part 'dashboard_view_event.dart';
part 'dashboard_view_state.dart';

class DashboardViewBloc extends Bloc<DashboardViewEvent, DashboardViewState> {
  DashboardViewBloc() : super(DashboardViewInitial()) {

    FirestoreDataSource firestoreDataSource = FirestoreDataSource();
    NewsApi newsApi = NewsApi();

    on<SpecialistsClickEvent>((event, emit) async{
      emit(DashboardLoadingState());
      List<DoctorModel>docModels=await firestoreDataSource.getDoctorModelList();
      emit(SpecialistPageState(docModels:docModels));
    });

    on<ChatsClickEvent>((event, emit) {
      emit(ChatsPageState());
    });

    on<ConsultationsClickEvent>((event, emit) async{
      List<AppointmentModel>appointmentModels;
      emit(DashboardLoadingState());
      appointmentModels = await firestoreDataSource.fetchAppointments(event.currentUserId);
      emit(ConsultationsPageState(appointmentModels: appointmentModels));
    });

    on<ArticlesClickEvent>((event, emit) async{
      emit(DashboardLoadingState());
      List<ArticleModel>articleModels=await newsApi.fetchHealthNews();
      emit(ArticlesPageState(articleModels: articleModels));
    });

    on<ProfileClickEvent>((event, emit) async{
      emit(DashboardLoadingState());
      UserModel? userModel = await firestoreDataSource.getUserModel(event.currentUserId);
      emit(ProfilePageState(userModel: userModel!));
    });

  }
}
