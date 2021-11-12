import 'package:flutter/material.dart';

pushPage(BuildContext context, Widget newPage) {
  return Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return newPage;
  }));
}

pushPageAsReplacement(BuildContext context, Widget newPage) {
  return Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) {
    return newPage;
  }));
}

popPage(context) {
  return Navigator.pop(context);
}

popUntil(BuildContext context, Widget newPage) {
  return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) {
    return newPage;
  }), (_) => false);
}
