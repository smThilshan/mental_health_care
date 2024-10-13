part of 'signin_page_bloc.dart';

@immutable
abstract class SigninPageEvent {}

class SignInEvent extends SigninPageEvent{
  final String email;
  final String password;
  SignInEvent({required this.email,required this.password});
}