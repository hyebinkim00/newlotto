import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:newlotto/push/firebase_message.dart';
import 'package:permission_handler/permission_handler.dart';

import 'config/constants.dart';
import 'config/route_names.dart';
import 'notification.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase 초기화

  // FCM token
  FirebaseMessaging.instance.getToken().then((token) {
    print("FCM Token: $token");
  });

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
  await FlutterLocalNotification.init();  // Local Notification 초기화
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await MessageSetting.setupFlutterNotifications();

  await initializeDateFormatting(); // 달력 시간대
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received message: ${message.data}");
      MessageSetting.showFlutterNotification(message);
      getpermission();
      // 추가적인 처리 로직 추가
    });
    super.initState();
  }

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
            primaryColor: Colors.black
          ),
          // Splash 화면 (권한 요청)
          initialRoute: RouteNames.MAIN,
          getPages: Constants.APP_PAGES,
        );
      },
    );
  }
}


void getpermission() async {
  await Permission.notification.request();
  if(await Permission.notification.request().isDenied){

  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  print('mmm${message}');
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MessageSetting.showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}
