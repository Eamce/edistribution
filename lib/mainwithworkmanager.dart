// import 'dart:async';
// import 'package:edistribution/router/routeConstant.dart';
// import 'package:edistribution/router/router.dart';
// import 'package:edistribution/services/notification.dart';
// import 'package:edistribution/values/branding_color.dart';
// import 'package:edistribution/values/images.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:root_check/root_check.dart';
// import 'package:workmanager/workmanager.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('ic_launcher');
//   final IOSInitializationSettings initializationSettingsIOS =
//       IOSInitializationSettings();
//   final MacOSInitializationSettings initializationSettingsMacOS =
//       MacOSInitializationSettings();
//   final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//       macOS: initializationSettingsMacOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: selectNotification);
//   Workmanager().initialize(
//     callbackDispatcher,
//     isInDebugMode: true,
//   );
//   Workmanager().registerPeriodicTask(
//     '1',
//     'uniqueKey',
//     frequency: Duration(seconds: 5),
//   );

//   runApp(Distribution());
// }

// class Distribution extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);

//     return ScreenUtilInit(
//       builder: () => MaterialApp(
//         title: 'E-Distribution',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: brandingColor,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           bottomSheetTheme: BottomSheetThemeData(
//               backgroundColor: Colors.black.withOpacity(0)),
//         ),
//         onGenerateRoute: Routers.onGenerateRoute,
//         home: Splash(),
//       ),
//     );
//   }
// }

// class Splash extends StatefulWidget {
//   const Splash({Key? key}) : super(key: key);

//   @override
//   _SplashState createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   bool? isRootedDevice = false;

//   @override
//   void initState() {
//     super.initState();

//     //initialize local notification
//     NotificationService notificationService = NotificationService();
//     notificationService.initialize();
//     //initialize local notification

//     initPlatformStateCheckRooted();
//     Timer(Duration(seconds: 5), () {
//       checkFirstSeen();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: brandingColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//               child: Image.asset(
//                 Images.logo,
//                 width: 85,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> initPlatformStateCheckRooted() async {
//     bool? isRooted = await RootCheck.isRooted;
//     if (!mounted) return;
//     isRootedDevice = isRooted;
//     setState(() {});
//   }

//   Future checkFirstSeen() async {
//     if (isRootedDevice == false) {
//       Navigator.pushNamed(context, menuRoute);
//     } else {
//       Navigator.pushNamed(context, trustFallRoute);
//     }
//   }
// }

// void callbackDispatcher() {
//   Workmanager().executeTask(
//     (task, inputData) async {
//       if (task == 'uniqueKey') {
//         //task in backend
//         //http request here

//         final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//             FlutterLocalNotificationsPlugin();

//         const AndroidInitializationSettings androidInitializationSettings =
//             AndroidInitializationSettings("ic_launcher");

//         const IOSInitializationSettings iosInitializationSettings =
//             IOSInitializationSettings();

//         const AndroidNotificationDetails androidPlatformChannelSpecifics =
//             AndroidNotificationDetails(
//                 'channel id', 'channelName', 'channelDescription',
//                 importance: Importance.max,
//                 priority: Priority.high,
//                 showWhen: false);

//         const IOSNotificationDetails iosNotificationDetails =
//             IOSNotificationDetails();

//         const NotificationDetails platformChannelSpecifics =
//             NotificationDetails(android: androidPlatformChannelSpecifics);

//         await flutterLocalNotificationsPlugin.show(
//           0,
//           'title',
//           'body',
//           platformChannelSpecifics,
//           payload: 'item',
//         );

//         // NotificationService notification = NotificationService();
//         // notification.instantNotification();
//       }
//       return Future.value(true);
//     },
//   );
// }

// Future selectNotification(String? payload) async {
//   debugPrint('notification payload: $payload');
// }
