import 'package:flutter/material.dart';

navegatorPushRoute({required String? route, dynamic context}) {
  return Navigator.pushNamed(context, route!);
}

navgatorPopRoute(context) {
  Navigator.pop(context);
}
