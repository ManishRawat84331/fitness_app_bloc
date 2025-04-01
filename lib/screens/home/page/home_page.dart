import 'package:fitness_app/screens/home/bloc/home_bloc.dart';
import 'package:fitness_app/screens/home/widget/home_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  BlocProvider<HomeBloc> _buildContext(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is HomeInitial,
        builder: (context, state) {
          return HomeContent();
        },
        listenWhen: (previous, current) => true,
        listener: (context, state) {},
      ),
    );
  }
}
