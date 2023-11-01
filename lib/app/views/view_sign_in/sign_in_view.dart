import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_sign_in/view_model/sign_in_state.dart';
import 'package:gymplus/app/views/view_sign_in/view_model/sign_in_view_model.dart';
import 'package:gymplus/app/views/view_sign_in/widgets/sign_in_content.dart';
import 'package:gymplus/app/views/view_sign_up/sign_up_view.dart';
import 'package:gymplus/app/views/view_tab_bar/tab_bar_view.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<SignInViewModel> _buildContext(BuildContext context) {
    return BlocProvider<SignInViewModel>(
      create: (BuildContext context) => SignInViewModel(),
      child: BlocConsumer<SignInViewModel, SignInState>(
        buildWhen: (_, currState) => currState is SignInInitial,
        builder: (context, state) {
          return const SignInContent();
        },
        listenWhen: (_, currState) =>
            currState is NextForgotPasswordPageState || currState is NextSignUpPageState || currState is NextTabBarPageState || currState is ErrorState,
        listener: (context, state) {
          if (state is NextForgotPasswordPageState) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
          } else if (state is NextSignUpPageState) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignUpPage()));
          } else if (state is NextTabBarPageState) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const TabBarPage()));
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
      ),
    );
  }
}