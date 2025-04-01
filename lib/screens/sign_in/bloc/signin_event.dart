
part of 'signin_bloc.dart';
abstract class SigninEvent{}


class OnTextChangedEvent  extends SigninEvent{}


class SignInTappedEvent extends SigninEvent {}

class SignUpTappedEvent extends SigninEvent {}

class ForgotPasswordTappedEvent extends SigninEvent {}
