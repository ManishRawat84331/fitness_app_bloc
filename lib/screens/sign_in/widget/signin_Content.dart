import 'package:fitness_app/core/const/color_constants.dart';
import 'package:fitness_app/core/const/text_constants.dart';
import 'package:fitness_app/core/service/validation_service.dart';
import 'package:fitness_app/screens/common_widgets/fitness_button.dart';
import 'package:fitness_app/screens/common_widgets/fitness_loading.dart';
import 'package:fitness_app/screens/common_widgets/fitness_text_field.dart';
import 'package:fitness_app/screens/sign_in/bloc/signin_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninContent extends StatelessWidget {
  const SigninContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: Stack(
        children: [
          _createMainData(context),
          BlocBuilder<SigninBloc, SigninState>(
            buildWhen: (_, currState) =>
                currState is LoadingState ||
                currState is ErrorState ||
                currState is NextTabBarPageState,
            builder: (context, state) {
              if (state is LoadingState) {
                return _createLoading();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _createMainData(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: height - 30 - MediaQuery.of(context).padding.bottom,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _createHeader(),
              const SizedBox(height: 50),
              _createForm(context),
              const SizedBox(height: 20),
              _createForgotPasswordButton(context),
              const SizedBox(height: 40),
              _createSigninButton(context),
              const Spacer(),
              _createDoNotHaveAccountText(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createLoading() {
    return FitnessLoading();
  }

  Widget _createHeader() {
    return const Center(
      child: Text(
        TextConstants.signIn,
        style: TextStyle(
          color: ColorConstants.textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    final bloc = BlocProvider.of<SigninBloc>(context);
    return BlocBuilder<SigninBloc, SigninState>(
      buildWhen: (_, currState) => currState is ShowErrorState,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FitnessTextField(
              title: TextConstants.email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              placeholder: TextConstants.emailPlaceholder,
              controller: bloc.emailController,
              isError: state is ShowErrorState
                  ? !ValidationService.email(bloc.emailController.text)
                  : false,
              errorText: TextConstants.emailErrorText,
              onTextChanged: () {
                bloc.add(OnTextChangedEvent());
              },
            ),
            const SizedBox(height: 20),
            FitnessTextField(
              title: TextConstants.password,
              placeholder: TextConstants.passwordPlaceholderSignIn,
              controller: bloc.passwordController,
              errorText: TextConstants.passwordErrorText,
              isError: state is ShowErrorState
                  ? !ValidationService.password(bloc.passwordController.text)
                  : false,
              obscureText: true,
              onTextChanged: () {
                bloc.add(OnTextChangedEvent());
              },
            ),
          ],
        );
      },
    );
  }

  Widget _createForgotPasswordButton(BuildContext context) {
    final bloc = BlocProvider.of<SigninBloc>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        bloc.add(ForgotPasswordTappedEvent());
        
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 21),
        child: Text(
          TextConstants.forgotPassword,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorConstants.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _createSigninButton(BuildContext context) {
    final bloc = BlocProvider.of<SigninBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<SigninBloc, SigninState>(
        buildWhen: (_, currState) =>
            currState is SigninButtonEnabledChangedState,
        builder: (context, state) {
          return FitnessButton(
            title: TextConstants.signIn,
            isEnabled: state is SigninButtonEnabledChangedState
                ? state.isEnabled
                : false,
            onTap: () {
              FocusScope.of(context).unfocus();
              bloc.add(SignInTappedEvent());
            },
          );
        },
      ),
    );
  }

  Widget _createDoNotHaveAccountText(BuildContext context) {
    final bloc = BlocProvider.of<SigninBloc>(context);
    return Center(
      child: RichText(
        text: TextSpan(
          text: TextConstants.doNotHaveAnAccount,
          style: const TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 18,
          ),
          children: [
            TextSpan(
              text: " ${TextConstants.signUp}",
              style: const TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  bloc.add(SignUpTappedEvent());
                },
            ),
          ],
        ),
      ),
    );
  }
}
