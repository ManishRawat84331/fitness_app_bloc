import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/core/service/auth_service.dart';
import 'package:fitness_app/core/service/validation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<OnTextChangedEvent>(_onTextChanged);
    on<SignInTappedEvent>(_onSigninTapped); // ✅ Corrected event type
    on<ForgotPasswordTappedEvent>(
        (event, emit) => emit(NextForgotPasswordPageState()));
    on<SignUpTappedEvent>((event, emit) => emit(NextSignupPageState()));
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  void _onTextChanged(OnTextChangedEvent event, Emitter<SigninState> emit) {
    bool isEnabled = checkIfSignupButtonEnabled();
    emit(SigninButtonEnabledChangedState(isEnabled: isEnabled));
  }

  bool checkIfSignupButtonEnabled() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  bool checkValidatorsOfTextField() {
    return ValidationService.email(emailController.text) &&
        ValidationService.password(passwordController.text);
  }

  Future<void> _onSigninTapped(
      SignInTappedEvent event, Emitter<SigninState> emit) async {
    // ✅ Fixed parameter order
    if (checkValidatorsOfTextField()) {
      try {
        emit(LoadingState());
        await AuthService.signIn(
            emailController.text.trim(), passwordController.text.trim());
        emit(NextTabBarPageState());
      } catch (e) {
        emit(ErrorState(message: e.toString()));
      }
    } else {
      emit(ShowErrorState());
    }
  }
}
