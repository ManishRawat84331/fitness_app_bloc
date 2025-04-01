
part of 'signup_bloc.dart';


abstract class SignupEvent {}

class OnTextChangedEvent extends SignupEvent{

}

class SignupTappedEvent extends SignupEvent{}

class SignInTappedEvent extends SignupEvent{}