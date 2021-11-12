import 'package:flutter/material.dart';
import 'package:frsc_presentation/size_config/size_config.dart';
import 'package:frsc_presentation/utilities/colors.dart';

class CustomBigBlueButton extends StatelessWidget {
  void Function()? pressed;
  final String? buttonText;
  CustomBigBlueButton({
    this.pressed,
    this.buttonText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SizedBox(
      width: SizeConfig.screenWidth! / 1.1,
      height: SizeConfig.screenHeight! / 11,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColors.primary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)))),
        onPressed: pressed,
        child: Text(
          buttonText!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
