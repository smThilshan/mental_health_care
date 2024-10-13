import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/data/data_sources/firebase_firestore.dart';
import 'package:mental_health/data/models/message_model.dart';
import 'package:mental_health/presentation/views/articles_view/articles_list.dart';
import 'package:mental_health/presentation/views/articles_view/articles_title_header.dart';
import 'package:mental_health/presentation/views/chats_view/chats_list.dart';
import 'package:mental_health/presentation/views/chats_view/chats_search_field.dart';
import 'package:mental_health/presentation/views/chats_view/chats_title_header.dart';
import 'package:mental_health/presentation/views/consultations_view/consultations_list.dart';
import 'package:mental_health/presentation/views/consultations_view/consultations_title_header.dart';
import 'package:mental_health/presentation/views/dashboard_view/widgets/custom_bottom_navigation_bar.dart';
import 'package:mental_health/presentation/views/profile_view/profile_about_box.dart';
import 'package:mental_health/presentation/views/profile_view/profile_title_header.dart';
import 'package:mental_health/presentation/views/specialist_view/specialists_view.dart';
import 'package:mental_health/presentation/views/specialist_view/specialists_filtering_header.dart';
import 'package:mental_health/presentation/views/specialist_view/specialists_title_header.dart';

import '../../../data/models/doctor_model.dart';
import '../../bloc/dashboard_view/dashboard_view_bloc.dart';
import '../profile_view/profile_options.dart';

class DashboardView extends StatefulWidget {
  final User user;
  const DashboardView({Key? key, required this.user}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late List<DoctorModel> docs;
  FirestoreDataSource firestoreDataSource = FirestoreDataSource();

  @override
  void initState() {
    BlocProvider.of<DashboardViewBloc>(context).add(SpecialistsClickEvent());
    getMethod();
  }
  
  void getMethod ()async{
    List<MessageModel>messageModels=await firestoreDataSource.getMessageModelList('1Ir0oUfguBPChwildvuit5FeYAE3', 'KUiI4TGvU2GqPxwAPYIn');
    print(messageModels[1].body);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DashboardViewBloc, DashboardViewState>(
          builder: (context, state) {
            ///STATE IS SPECIALIST PAGE STATE/////
            if (state is SpecialistPageState) {
              return Column(
                children: <Widget>[
                  SpecialistsTitleHeader(),
                  SpecialistsFilteringHeader(),
                  Expanded(
                    child: SpecialistView(docModels: state.docModels,
                    currentUserId: widget.user.uid,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomBottomNavigationBar(
                          currentUserId: widget.user.uid,
                          articlesSelected: false,
                          chatsSelected: false,
                          consultationsSelected: false,
                          profileSelected: false,
                          specialistSelected: true,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            ///STATE IS CHAT PAGE STATE/////
            else if (state is ChatsPageState) {
              return Column(
                children: <Widget>[
                  ChatsTitleHeader(),
                  ChatsSearchField(),
                  Expanded(child: ChatsList(
                    currentUserId: widget.user.uid,
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomBottomNavigationBar(
                          currentUserId: widget.user.uid,
                          articlesSelected: false,
                          chatsSelected: true,
                          consultationsSelected: false,
                          profileSelected: false,
                          specialistSelected: false,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            ///STATE IS CONSULTANT PAGE STATE/////
            else if (state is ConsultationsPageState) {
              return Column(
                children: <Widget>[
                  ConsultationsTitleHeader(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ConsultationsList(
                        currentUserId: widget.user.uid,
                        onCancelButtonPressed: ()async{
                          BlocProvider.of<DashboardViewBloc>(context).add(ConsultationsClickEvent(currentUserId: widget.user.uid));
                          },
                        appointmentModels: state.appointmentModels,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomBottomNavigationBar(
                          currentUserId: widget.user.uid,
                          articlesSelected: false,
                          chatsSelected: false,
                          consultationsSelected: true,
                          profileSelected: false,
                          specialistSelected: false,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }


            ///STATE IS ARTICLES PAGE STATE/////
            else if (state is ArticlesPageState) {
              return Column(
                children: <Widget>[
                  ArticlesTitleHeader(),
                  Expanded(
                    child: ArticlesList(articleModels: state.articleModels),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomBottomNavigationBar(
                          currentUserId: widget.user.uid,
                          articlesSelected: true,
                          chatsSelected: false,
                          consultationsSelected: false,
                          profileSelected: false,
                          specialistSelected: false,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            ///STATE IS PROFILE PAGE STATE/////
            else if (state is ProfilePageState) {
              return Column(
                children: <Widget>[
                  ProfileTitleHeader(),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        ProfileAboutBox(
                          displayName: state.userModel.displayName.toString(),
                          email: state.userModel.email.toString(),
                          gender: state.userModel.gender.toString(),
                          uid: widget.user.uid,
                        ),
                        ProfileOptions(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomBottomNavigationBar(
                          currentUserId: widget.user.uid,
                          articlesSelected: false,
                          chatsSelected: false,
                          consultationsSelected: false,
                          profileSelected: true,
                          specialistSelected: false,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            if (state is DashboardLoadingState) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(color: Colors.deepPurpleAccent,
                        backgroundColor: Colors.pink,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomBottomNavigationBar(
                          currentUserId: widget.user.uid,
                          articlesSelected: false,
                          chatsSelected: false,
                          consultationsSelected: false,
                          profileSelected: false,
                          specialistSelected: false,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }


            /// ELSE /////////////////
            else {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Column(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomBottomNavigationBar(
                          currentUserId: widget.user.uid,
                          articlesSelected: false,
                          chatsSelected: false,
                          consultationsSelected: false,
                          profileSelected: false,
                          specialistSelected: false,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
