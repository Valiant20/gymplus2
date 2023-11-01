import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_home_page/view_model/home_page_state.dart';
import 'package:gymplus/app/views/view_home_page/view_model/home_page_view_model.dart';
import 'package:gymplus/app/views/view_home_page/widgets/home_page_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<HomePageViewModel> _buildContext(BuildContext context) {
    return BlocProvider<HomePageViewModel>(
      create: (BuildContext context) => HomePageViewModel(),
      child: BlocConsumer<HomePageViewModel, HomeState>(
        buildWhen: (_, currState) => currState is HomeInitial,
        builder: (context, state) {
          return HomeContent();
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }
}