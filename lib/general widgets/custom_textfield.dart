import 'package:flutter/material.dart';
import 'package:frsc_presentation/size_config/size_config.dart';
import 'package:frsc_presentation/utilities/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.autoCorrect,
    this.inputAction = TextInputAction.next,
    this.controller,
    this.labelText,
    this.hintText,
  }) : super(key: key);

  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final TextEditingController? controller;
  final bool? isPassword;
  final bool? autoCorrect;
  final String? labelText;
  final String? hintText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? isPasswordVisible;
  bool isEmpty = true;

  @override
  void initState() {
    isPasswordVisible = true;
    widget.controller!.addListener(() {
      if (widget.controller!.text == "") {
        setState(() {
          isEmpty = true;
        });
      } else {
        isEmpty = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      height: SizeConfig.screenHeight! / 12,
      child: TextField(
        obscureText: widget.isPassword! ? isPasswordVisible! : false,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.inputAction,
        autocorrect: widget.autoCorrect!,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintStyle: const TextStyle(fontSize: 15),
          hintText: widget.hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: AppColors.headerTextColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(
                width: 2,
                color: AppColors.subtextColor,
              )),
          suffixIcon: widget.isPassword!
              ? IconButton(
                  padding: const EdgeInsets.only(right: 10),
                  icon: Icon(
                    isPasswordVisible!
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible!;
                    });
                  },
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 21, horizontal: 20),
        ),
      ),
    );
  }
}
