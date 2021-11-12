import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frsc_presentation/core/services/auth.dart';
import 'package:frsc_presentation/screens/login/login_view.dart';
import 'package:frsc_presentation/size_config/size_config.dart';
import 'package:frsc_presentation/utilities/colors.dart';
import 'package:frsc_presentation/utilities/navigation.dart';
import 'package:frsc_presentation/utilities/style.dart';
import 'package:frsc_presentation/utilities/ui_helper.dart';

class YourProfileView extends StatefulWidget {
  const YourProfileView({Key? key}) : super(key: key);

  @override
  _YourProfileViewState createState() => _YourProfileViewState();
}

class _YourProfileViewState extends State<YourProfileView> {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
      ),
      body: Container(
          decoration: const BoxDecoration(color: AppColors.primary),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                width: SizeConfig.screenWidth! / 1.2,
                height: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Account Profile',
                            style: AppTextStyles.heading6White),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Icon(Icons.person,
                              color: AppColors.white, size: 30),
                        ),
                      ],
                    )
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
                      UIHelper.verticalSpaceRegular,
                      ListTile(
                        title: Text('Settings', style: AppTextStyles.heading6),
                        leading: Icon(
                          Icons.settings,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                      ListTile(
                        onTap: () async => AuthService(FirebaseAuth.instance)
                            .logOut()
                            .then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Logging out!'),
                                ),
                              ),
                            )
                            .then((value) =>
                                pushPage(context, const LoginView())),
                        title: Text('Logout', style: AppTextStyles.heading6),
                        leading: Icon(
                          Icons.logout,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ))),
    );
  }
}
