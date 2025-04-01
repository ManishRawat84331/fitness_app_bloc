import 'package:fitness_app/core/const/color_constants.dart';
import 'package:fitness_app/core/const/text_constants.dart';
import 'package:fitness_app/core/service/validation_service.dart';
import 'package:fitness_app/screens/common_widgets/fitness_button.dart';
import 'package:fitness_app/screens/common_widgets/fitness_loading.dart';
import 'package:fitness_app/screens/common_widgets/fitness_text_field.dart';
import 'package:fitness_app/screens/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordContent extends StatefulWidget {
  const ForgotPasswordContent({Key? key}) : super(key: key);

  @override
  _ForgotPasswordContentState createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<ForgotPasswordContent> {
  bool _isButtonEnabled = false;
  bool _isTextFieldError = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordError) {
          setState(() => _isTextFieldError = true);
        } else if (state is ForgotPasswordSuccess) {
          setState(() => _isTextFieldError = false);
          // Show a success message/snackbar here if needed
        }
      },
      child: Stack(
        children: [
          _createMainData(context),
          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: (context, state) {
              if (state is ForgotPasswordLoading) {
                return _createLoading();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _createLoading() {
    return FitnessLoading();
  }

  Widget _createMainData(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: height -
              30 -
              MediaQuery.of(context).padding.bottom -
              kToolbarHeight,
          child: Column(
            children: [
              const Spacer(flex: 2),
              _createForm(context),
              const Spacer(flex: 3),
              _createResetPasswordButton(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    final bloc = BlocProvider.of<ForgotPasswordBloc>(context);
    return FitnessTextField(
      title: TextConstants.email,
      keyboardType: TextInputType.emailAddress,
      placeholder: TextConstants.emailPlaceholder,
      controller: bloc.emailController,
      errorText: TextConstants.emailErrorText,
      isError: _isTextFieldError,
      onTextChanged: () {
        if (mounted) {
          setState(
              () => _isButtonEnabled = bloc.emailController.text.isNotEmpty);
        }
      },
    );
  }

  Widget _createResetPasswordButton(BuildContext context) {
    final bloc = BlocProvider.of<ForgotPasswordBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FitnessButton(
        title: TextConstants.sendActivationBuild,
        isEnabled: _isButtonEnabled,
        onTap: () {
          FocusScope.of(context).unfocus();
          if (_isButtonEnabled) {
            final isValidEmail =
                ValidationService.email(bloc.emailController.text);
            setState(() => _isTextFieldError = !isValidEmail);
            if (isValidEmail) {
              bloc.add(ForgotPasswordTappedEvent());
            }
          }
        },
      ),
    );
  }
}
