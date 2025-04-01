import 'package:bloc/bloc.dart';
import 'package:fitness_app/core/service/auth_service.dart';
import 'package:flutter/material.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final emailController = TextEditingController();
  bool isError = false;

  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordTappedEvent>(_onForgotPasswordTappedEvent);
  }

  Future<void> _onForgotPasswordTappedEvent(
      ForgotPasswordTappedEvent event, Emitter<ForgotPasswordState> emit) async {
    try {
      emit(ForgotPasswordLoading());
      await AuthService.resetPassword(emailController.text);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
