// import 'package:flutter/cupertino.dart';
// import 'package:frsc_presentation/app/locator.dart';
// import 'package:frsc_presentation/core/models/user.dart';
// import 'package:frsc_presentation/core/services/auth.dart';

// class SignUpViewModel extends ChangeNotifier {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   FormFieldState<String> state;
//   final _signup = GlobalKey<FormState>();

//   final _auth = locator<AuthService>();

//   get signup => _signup;

//   //email validation
//   bool emailValidator(String value) {
//     Pattern pattern =
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     RegExp regex = RegExp(pattern);
//     return (!regex.hasMatch(value)) ? false : true;
//   }

//   void formValidation(BuildContext context) async {
//     if (_signup.currentState.validate()) {
//       await _auth.signUp(context, email, password)(
//         context,
//         User(
//           fullName: fullname.text.trim(),
//           email: emailController.text.trim(),
//           password: passwordController.text,
//         ),
//       );
//       print(fullname.text);
//       //await Navigator.pushReplacementNamed(context, Routes.homeView);
//       print('Verified');
//     }
//   }
// }
