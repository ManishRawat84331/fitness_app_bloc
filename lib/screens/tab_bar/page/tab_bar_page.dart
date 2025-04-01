import 'package:fitness_app/core/const/color_constants.dart';
import 'package:fitness_app/core/const/path_constants.dart';
import 'package:fitness_app/core/const/text_constants.dart';
import 'package:fitness_app/screens/home/page/home_page.dart';
import 'package:fitness_app/screens/home/widget/home_content.dart';
import 'package:fitness_app/screens/settings/setting_page.dart';
import 'package:fitness_app/screens/tab_bar/bloc/tab_bar_bloc.dart';
import 'package:fitness_app/screens/workouts/page/workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (BuildContext context) => TabBarBloc(),
      child: BlocConsumer<TabBarBloc, TabBarState>(
        listener: (context, state) {},
        buildWhen: (_, currState) =>
            currState is TabBarInitial || currState is TabBarItemSelectedState,
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarBloc>(context);
          return Scaffold(
            body: _createBody(context, bloc.currentIndex),
            bottomNavigationBar: _createBottomTabBar(context),
          );
        },
      ),
    );
  }

  Widget _createBottomTabBar(BuildContext content) {
    final bloc = BlocProvider.of<TabBarBloc>(content);
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image(
            image: AssetImage(PathConstants.home),
            color: bloc.currentIndex == 0 ? ColorConstants.primaryColor : null,
          ),
          label: TextConstants.homeIcon,
        ),
        BottomNavigationBarItem(
          icon: Image(
            image: AssetImage(PathConstants.workouts),
            color: bloc.currentIndex == 1 ? ColorConstants.primaryColor : null,
          ),
          label: TextConstants.workout,
        ),
        BottomNavigationBarItem(
          icon: Image(
            image: AssetImage(PathConstants.settings),
            color: bloc.currentIndex == 2 ? ColorConstants.primaryColor : null,
          ),
          label: TextConstants.settings,
        )
      ],
      onTap: (index) {
        bloc.add(TabBarItemTappedEvent(index: index));
      },
    );
  }

  Widget _createBody(BuildContext context, int index) {
    final children = [HomePage(), WorkoutsPage(), SettingsScreen()];
    return children[index];
  }
}
