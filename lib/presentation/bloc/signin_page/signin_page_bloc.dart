import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/data/repositories/firebase_features.dart';
import 'package:meta/meta.dart';

part 'signin_page_event.dart';
part 'signin_page_state.dart';

class SigninPageBloc extends Bloc<SigninPageEvent, SigninPageState> {
  SigninPageBloc() : super(SigninPageInitial()) {
    FirebaseFeatures firebaseFeatures = FirebaseFeatures();


    on<SignInEvent>((event, emit) async{
      emit(SigninPageLoading());
      User user = await firebaseFeatures.signInUser(event.email, event.password);
      emit(SigninPageLoaded(user: user));
    });

  }
}
