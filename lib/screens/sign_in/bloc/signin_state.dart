part of 'signin_bloc.dart';
abstract class SigninState{
  const SigninState();
}

class SigninInitial extends SigninState{}

class SigninButtonEnabledChangedState extends SigninState{

final bool isEnabled;

SigninButtonEnabledChangedState({
  required this.isEnabled
});

}

class ShowErrorState extends SigninState {}

class NextForgotPasswordPageState extends SigninState {}

class NextSignupPageState extends SigninState {}

class NextTabBarPageState extends SigninState {}

class ErrorState extends SigninState {
  final String message;

  ErrorState({
    required this.message,
  });
}

class LoadingState extends SigninState {}
