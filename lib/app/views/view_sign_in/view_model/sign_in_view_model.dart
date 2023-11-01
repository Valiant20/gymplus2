import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_sign_in/view_model/sign_in_event.dart';
import 'package:gymplus/app/views/view_sign_in/view_model/sign_in_state.dart';
import 'package:gymplus/core/service/auth_service.dart';
import 'package:gymplus/core/service/validation_service.dart';

class SignInViewModel extends Bloc<SignInEvent, SignInState> {
  SignInViewModel() : super(SignInInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isButtonEnabled = false;

  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is OnTextChangeEvent) {
      if (isButtonEnabled != _checkIfSignInButtonEnabled()) {
        isButtonEnabled = _checkIfSignInButtonEnabled();
        yield SignInButtonEnableChangedState(isEnabled: isButtonEnabled);
      }
    } else if (event is SignInTappedEvent) {
      if (_checkValidatorsOfTextField()) {
        try {
          yield LoadingState();
          await AuthService.signIn(emailController.text, passwordController.text);
          yield NextTabBarPageState();
          print("Go to the next page");
        } catch (e) {
          print('E to tstrng: ' + e.toString());
          yield ErrorState(message: e.toString());
        }
      } else {
        yield ShowErrorState();
      }
    } else if (event is ForgotPasswordTappedEvent) {
      yield NextForgotPasswordPageState();
    } else if (event is SignUpTappedEvent) {
      yield NextSignUpPageState();
    }
  }

  bool _checkIfSignInButtonEnabled() {
    return emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  bool _checkValidatorsOfTextField() {
    return ValidationService.email(emailController.text) && ValidationService.password(passwordController.text);
  }
}