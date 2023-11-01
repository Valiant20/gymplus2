import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymplus/core/constants/color_constants.dart';

class FitnessLoading extends StatelessWidget {
  const FitnessLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ColorConstants.loadingBlack,
      child: Center(
        child: Theme(
          data: ThemeData(
            cupertinoOverrideTheme:
                const CupertinoThemeData(brightness: Brightness.dark),
          ),
          child: const CupertinoActivityIndicator(
            radius: 17,
          ),
        ),
      ),
    );
  }
}