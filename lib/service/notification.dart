import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDate,
  }) async {
    tz.initializeTimeZones();
    var jakarta = tz.getLocation('Asia/Jakarta');
    var setupTime = tz.TZDateTime.from(scheduleDate, jakarta);
    return _notifications.zonedSchedule(
        id, title, body, setupTime, await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future _notificationDetails() async {
    // const sound = 'soundalarm.wav'; //Belom input sound nya
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        channelDescription: 'channelDesc',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static void cancel() => _notifications.cancelAll();
}
