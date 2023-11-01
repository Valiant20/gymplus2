import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_home_page/home_page_view.dart';
import 'package:gymplus/app/views/view_tab_bar/view_model/tab_bar_event.dart';
import 'package:gymplus/app/views/view_tab_bar/view_model/tab_bar_state.dart';
import 'package:gymplus/app/views/view_tab_bar/view_model/tab_bar_view_model.dart';
import 'package:gymplus/app/views/view_workouts/workouts_view.dart';
import 'package:gymplus/core/constants/color_constants.dart';
import 'package:gymplus/core/constants/path_constants.dart';
import 'package:gymplus/core/constants/text_constants.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarViewModel>(
      create: (BuildContext context) => TabBarViewModel(),
      child: BlocConsumer<TabBarViewModel, TabBarState>(
        listener: (context, state) {},
        buildWhen: (_, currState) =>
            currState is TabBarInitial || currState is TabBarItemSelectedState,
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarViewModel>(context);
          return Scaffold(
            body: _createBody(context, bloc.currentIndex),
            bottomNavigationBar: _createdBottomTabBar(context),
          );
        },
      ),
    );
  }

  Widget _createdBottomTabBar(BuildContext context) {
    final bloc = BlocProvider.of<TabBarViewModel>(context);
    return BottomNavigationBar(
      currentIndex: bloc.currentIndex,
      fixedColor: ColorConstants.primaryColor,
      items: [
        BottomNavigationBarItem(
          icon: Image(
            image: const AssetImage(PathConstants.home),
            color: bloc.currentIndex == 0 ? ColorConstants.primaryColor : null,
          ),
          label: TextConstants.homeIcon,
        ),
        BottomNavigationBarItem(
          icon: Image(
            image: const AssetImage(PathConstants.workouts),
            color: bloc.currentIndex == 1 ? ColorConstants.primaryColor : null,
          ),
          label: TextConstants.workoutsIcon,
        ),
        BottomNavigationBarItem(
          icon: Image(
            image: const AssetImage(PathConstants.settings),
            color: bloc.currentIndex == 2 ? ColorConstants.primaryColor : null,
          ),
          label: TextConstants.settingsIcon,
        ),
      ],
      onTap: (index) {
        bloc.add(TabBarItemTappedEvent(index: index));
      },
    );
  }

  Widget _createBody(BuildContext context, int index) {
    final children = [
      const HomePage(),
      const WorkoutsPage(),
      SettingsScreen()
    ];
    return children[index];
  }
}