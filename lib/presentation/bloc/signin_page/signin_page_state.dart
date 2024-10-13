part of 'signin_page_bloc.dart';

@immutable
abstract class SigninPageState {}

class SigninPageInitial extends SigninPageState {}

class SigninPageLoading extends SigninPageState {}

class SigninPageLoaded extends SigninPageState {
  final User user;
  SigninPageLoaded({required this.user});
}



