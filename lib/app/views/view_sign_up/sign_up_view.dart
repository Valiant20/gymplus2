
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_sign_in/sign_in_view.dart';
import 'package:gymplus/app/views/view_sign_up/view_model/sign_up_state.dart';
import 'package:gymplus/app/views/view_sign_up/view_model/sign_up_view_model.dart';
import 'package:gymplus/app/views/view_sign_up/widgets/sign_up_content.dart';
import 'package:gymplus/app/views/view_tab_bar/tab_bar_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  BlocProvider<SignUpViewModel> _buildBody(BuildContext context) {
    return BlocProvider<SignUpViewModel>(
      create: (BuildContext context) => SignUpViewModel(),
      child: BlocConsumer<SignUpViewModel, SignUpState>(
        listenWhen: (_, currState) => currState is NextTabBarPageState || currState is NextSignInPageState || currState is ErrorState,
        listener: (context, state) {
          if (state is NextTabBarPageState) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const TabBarPage()));
          } else if (state is NextSignInPageState) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const SignInPage()));
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        buildWhen: (_, currState) => currState is SignupInitial,
        builder: (context, state) {
          return const SignUpContent();
        },
      ),
    );
  }
}