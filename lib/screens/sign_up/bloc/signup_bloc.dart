import 'dart:async';
import 'package:fitness_app/core/service/auth_service.dart';
import 'package:fitness_app/core/service/validation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<OnTextChangedEvent>(_onTextChanged);
    on<SignupTappedEvent>(_onSignUpTapped);
    on<SignInTappedEvent>(_onSignInTapped);
  }

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Future<void> close() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  void _onTextChanged(OnTextChangedEvent event, Emitter<SignupState> emit) {
    bool isEnabled = checkIfSignupButtonEnabled();
    emit(SignupButtonEnableChangedState(isEnabled: isEnabled)); // ✅ Fixed Typo
  }

  bool checkIfSignupButtonEnabled() {
    return userNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  bool checkValidatorsOfTextField() {
    return ValidationService.username(userNameController.text) &&
        ValidationService.email(emailController.text) &&
        ValidationService.password(passwordController.text) &&
        ValidationService.confirmPassword(
          passwordController.text,
          confirmPasswordController.text,
        );
  }

  Future<void> _onSignUpTapped(
      SignupTappedEvent event, Emitter<SignupState> emit) async {
    if (checkValidatorsOfTextField()) {
      try {
        emit(LoadingState());
        await AuthService.signup(
          emailController.text,
          passwordController.text,
          userNameController.text,
        );
        emit(NextTabBarPageState());
      } catch (e) {
        emit(ErrorState(message: e.toString()));
      }
    } else {
      emit(ShowErrorState());
    }
  }

  void _onSignInTapped(SignInTappedEvent event, Emitter<SignupState> emit) {
    emit(NextSignInPageState());
  }
}
