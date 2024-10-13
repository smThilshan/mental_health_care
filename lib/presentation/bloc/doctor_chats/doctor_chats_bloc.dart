import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mental_health/data/data_sources/firebase_firestore.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user_model.dart';

part 'doctor_chats_event.dart';
part 'doctor_chats_state.dart';

class DoctorChatsBloc extends Bloc<DoctorChatsEvent, DoctorChatsState> {
  DoctorChatsBloc() : super(DoctorChatsInitial()) {

    FirestoreDataSource firestoreDataSource = FirestoreDataSource();
    on<GetChatsEvent>((event, emit) async{
      emit(DoctorChatsLoading());
      List<UserModel>userList=await firestoreDataSource.getUsersFromConversation(event.currentUserId);
      emit(DoctorChatsLoaded(userList: userList));
    });

  }
}
