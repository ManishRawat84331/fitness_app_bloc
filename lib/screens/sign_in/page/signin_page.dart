import 'package:fitness_app/screens/sign_in/bloc/signin_bloc.dart';
import 'package:fitness_app/screens/sign_in/widget/signin_Content.dart';
import 'package:fitness_app/screens/sign_up/page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninBloc(),
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<SigninBloc, SigninState>(
      buildWhen: (_, currState) => currState is SigninInitial,
      builder: (context, state) {
        return const SigninContent();
      },
      listenWhen: (_, currState) =>
          currState is NextForgotPasswordPageState ||
          currState is NextSignupPageState ||
          currState is NextTabBarPageState ||
          currState is ErrorState,
      listener: (context, state) {
        if (state is NextForgotPasswordPageState) {
          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
        } else if (state is NextSignupPageState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => SignupPage()),
          );
        } else if (state is NextTabBarPageState) {
          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => TabBarPage()));
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
    );
  }
}
