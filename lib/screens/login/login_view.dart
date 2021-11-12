import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frsc_presentation/core/services/auth.dart';
import 'package:frsc_presentation/general%20widgets/custom_bigblue_button.dart';
import 'package:frsc_presentation/general%20widgets/custom_textfield.dart';
import 'package:frsc_presentation/utilities/colors.dart';
import 'package:frsc_presentation/utilities/navigation.dart';
import 'package:frsc_presentation/utilities/size_config/size_config.dart';
import 'package:frsc_presentation/utilities/style.dart';
import 'package:frsc_presentation/utilities/ui_helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        leading: IconButton(
            onPressed: () => popPage(context), icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
          decoration: const BoxDecoration(color: AppColors.primary),
          child: SingleChildScrollView(
              child: Form(
            child: Column(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 1.1,
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Log in', style: AppTextStyles.heading6White)
                    ],
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth!,
                  height: SizeConfig.screenHeight!,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIHelper.verticalSpaceMedium,
                        Text('Email', style: AppTextStyles.heading7),
                        UIHelper.verticalSpaceTiny,
                        CustomTextField(
                          hintText: 'Enter email',
                          autoCorrect: true,
                          controller: emailController,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text('Password', style: AppTextStyles.heading7),
                        UIHelper.verticalSpaceTiny,
                        CustomTextField(
                          hintText: 'Enter password',
                          autoCorrect: true,
                          controller: passwordController,
                          isPassword: true,
                        ),
                        UIHelper.verticalSpaceLarge,
                        CustomBigBlueButton(
                          buttonText: 'Login',
                          pressed: () {
                            final String email = emailController.text.trim();
                            final String password =
                                passwordController.text.trim();

                            if (email.isEmpty) {
                              // ignore: deprecated_member_use
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Email is empty')));
                            } else if (password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Password is empty')));
                            } else {
                              AuthService(FirebaseAuth.instance)
                                  .login(context, email, password)
                                  .then((value) async {
                                User user = FirebaseAuth.instance.currentUser!;
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ))),
    );
  }
}
