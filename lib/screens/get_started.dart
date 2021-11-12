import 'package:flutter/material.dart';
import 'package:frsc_presentation/general%20widgets/custom_big_white_button.dart';
import 'package:frsc_presentation/general%20widgets/custom_bigblue_button.dart';
import 'package:frsc_presentation/screens/login/login_view.dart';
import 'package:frsc_presentation/utilities/colors.dart';
import 'package:frsc_presentation/utilities/navigation.dart';
import 'package:frsc_presentation/utilities/style.dart';
import 'package:frsc_presentation/utilities/ui_helper.dart';

import 'signup/signup_view.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Stack(
          children: [
            Center(child: Text('FRSC', style: AppTextStyles.heading2White)),
            UIHelper.verticalSpaceMassive,
            Positioned(
                bottom: 100,
                child: CustomBigWhiteButton(
                  buttonText: 'Get Started',
                  pressed: () => pushPage(context, const SignUpView()),
                )),
            Positioned(
              bottom: 20,
              child: CustomBigBlueButton(
                buttonText: 'Sign in',
                pressed: () =>
                    pushPageAsReplacement(context, const LoginView()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
