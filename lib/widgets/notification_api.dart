import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            'channel id', 'channel name', 'channel description',
            importance: Importance.max),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initScheduled = false}) async {
    var androidInitialize =
        new AndroidInitializationSettings("@mipmap/ic_launcher_foreground");
    var initialzationSetting =
        new InitializationSettings(android: androidInitialize);
    await _notification.initialize(initialzationSetting,
        onSelectNotification: (payload) async {
      print('payload is working');
      onNotifications.add(payload);
    });
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notification.show(id, title, body, await _notificationDetails(),
        payload: payload);
  }
}
