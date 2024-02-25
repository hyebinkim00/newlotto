import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'config/constants.dart';
import 'config/route_names.dart';

Future<void> main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          title: 'NEW LOTTO',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: RouteNames.MAIN,
          getPages: Constants.APP_PAGES,
        );
      },
    );
  }
}
