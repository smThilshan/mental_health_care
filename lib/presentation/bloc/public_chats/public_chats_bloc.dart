import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/data/models/doctor_model.dart';
import 'package:meta/meta.dart';

import '../../../data/data_sources/firebase_firestore.dart';

part 'public_chats_event.dart';
part 'public_chats_state.dart';

class PublicChatsBloc extends Bloc<PublicChatsEvent, PublicChatsState> {

  PublicChatsBloc() : super(PublicChatsInitial()) {

      FirestoreDataSource firestoreDataSource = FirestoreDataSource();
      on<GetPublicChatsEvent>((event, emit) async{
        emit(PublicChatsChatsLoading());
        List<DoctorModel>doctorList=await firestoreDataSource.getDoctorsFromConversation(event.currentUserId);
        emit(PublicChatsLoaded(doctorList: doctorList));
      });

  }
}
