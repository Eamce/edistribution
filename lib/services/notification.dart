import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("launcher_icon");

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future instantNotification(
      int channelId, String sender, String msgbody) async {
    var android = AndroidNotificationDetails(
      "channelId",
      "channelName",
      // "channelDescription",
      enableVibration: true,
      onlyAlertOnce: true,
    );
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin.show(
        channelId, "$sender", "$msgbody", platform,
        payload: "Welcome to Demo app");
  }

  Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
