import 'package:fitness_app/screens/sign_in/page/signin_page.dart';
import 'package:fitness_app/screens/sign_up/bloc/signup_bloc.dart';
import 'package:fitness_app/screens/sign_up/widgets/signup_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  BlocProvider<SignupBloc> _buildBody(BuildContext context) {
    return BlocProvider<SignupBloc>(
      create: (BuildContext context) => SignupBloc(),
      child: BlocConsumer<SignupBloc, SignupState>(
        listenWhen: (_, currState) =>
            currState is NextTabBarPageState ||
            currState is NextSignInPageState ||
            currState is ErrorState,
        listener: (context, state) {
          if (state is NextTabBarPageState) {
            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => TabBarPage()));
          } else if (state is NextSignInPageState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => SigninPage()));
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        buildWhen: (_, currState) => currState is SignupInitial,
        builder: (context, state) {
          return SignupContent();
        },
      ),
    );
  }
}
