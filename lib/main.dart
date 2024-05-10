import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:newlotto/push/firebase_message.dart';

import 'config/constants.dart';
import 'config/route_names.dart';
import 'config/shared_pre.dart';
import 'notification.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(); // Firebase 초기화

  // FCM token
  // FirebaseMessaging.instance.getToken().then((token) {
  //   print("FCM Token: $token");
  // });
  //
  final SharedPreferencesService _prefsService = SharedPreferencesService.getInstance();

  await _prefsService.init();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
  // await FlutterLocalNotification.init();  // Local Notification 초기화
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await MessageSetting.setupFlutterNotifications();

  // await initializeDateFormatting(); // 달력 시간대
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
      // getpermission();
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
          locale: const Locale('ko','KR'),
          localizationsDelegates: [
            // 필요한 델리게이트 추가
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('ko', 'KR'),
            const Locale('en', 'US'), // 영어, 미국
            // 필요한 경우 추가적인 로케일들을 여기에 추가할 수 있습니다.
          ],
          // supportedLocales: const [
          //   Locale('ko', 'KR'), // Korean, no country code
          // ],
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          title: 'NEW LOTTO',
          theme: ThemeData(
            textTheme:TextTheme(
              bodyMedium: TextStyle(fontSize: 18), // 기본 텍스트 크기를 18로 설정
              headlineMedium: TextStyle(fontSize: 24), // 제목 텍스트 크기를 24로 설정
            ) ,
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


// void getpermission() async {
//   await Permission.notification.request();
//   if(await Permission.notification.request().isDenied){
//
//   }
// }

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  print('mmm${message}');
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MessageSetting.showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}
