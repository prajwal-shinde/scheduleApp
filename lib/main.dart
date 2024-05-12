import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app/app/app.locator.dart';
import 'package:schedule_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:device_preview/device_preview.dart';
void main()async{
  await setupLocator();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorKey: StackedService.navigatorKey,
    onGenerateRoute: StackedRouter().onGenerateRoute,
  ));
}

