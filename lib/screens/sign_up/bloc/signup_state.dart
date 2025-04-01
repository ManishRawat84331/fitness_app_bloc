part of 'signup_bloc.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupButtonEnableChangedState extends SignupState {
  final bool isEnabled;

  SignupButtonEnableChangedState({required this.isEnabled});
}

class ShowErrorState extends SignupState {}

class ErrorState extends SignupState {
  final String message;

  ErrorState({required this.message});
}

class NextTabBarPageState extends SignupState {}

class NextSignInPageState extends SignupState {}

class LoadingState extends SignupState {}
