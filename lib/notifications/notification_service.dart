import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  static const _ANDROID_NOTIFICATION_CHANNEL = "smartcam_notifications_channel";
  static const _ANDROID_NOTIFICATION_CHANNEL_NAME = "smartcam_notifications";

  NotificationsService._internal();

  static NotificationsService? _instance;

  factory NotificationsService.instance() =>
      _instance ??= NotificationsService._internal();

  late FirebaseMessaging _fbm;
  late FlutterLocalNotificationsPlugin _notificationPlugin;

  late AndroidNotificationChannel _androidNotificationChannel;

  Future<String?> get notificationToken async => _fbm.getToken();

  Future<void> initialize() async {
    await Firebase.initializeApp();

    _fbm = FirebaseMessaging.instance;
    _fbm.requestPermission();

    _notificationPlugin = FlutterLocalNotificationsPlugin();

    await _initializeLocalNotificationPlugin();

    if (Platform.isAndroid) {
      await _setupAndroidNotifications();
    }

    _initForegroundNotificationListener();
  }

  Future<void> _initializeLocalNotificationPlugin() async {
    _notificationPlugin.initialize(
      InitializationSettings(
        android: _getAndroidInitializationSettings(),
        iOS: _getIOSInitializationSettings(),
      ),
    );
  }

  Future<void> _setupAndroidNotifications() async {
    _androidNotificationChannel = const AndroidNotificationChannel(
      _ANDROID_NOTIFICATION_CHANNEL,
      _ANDROID_NOTIFICATION_CHANNEL_NAME,
      importance: Importance.high,
    );

    _notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannel);
  }

  IOSInitializationSettings _getIOSInitializationSettings() {
    return const IOSInitializationSettings();
  }

  AndroidInitializationSettings _getAndroidInitializationSettings() {
    return const AndroidInitializationSettings("launch_background");
  }

  void _initForegroundNotificationListener() {
    FirebaseMessaging.onMessage.listen(
      (event) async {
        final notification = event.notification;
        if (notification != null) {
          await showLocalNotification(
            id: notification.hashCode,
            name: notification.title ?? "Notification title",
            description: notification.body ?? "Notification body",
          );
        }
      },
    );
  }

  Future<void> showLocalNotification({
    required int id,
    required String name,
    required String description,
  }) async {
    await _notificationPlugin.show(
      id,
      name,
      description,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidNotificationChannel.id,
          _androidNotificationChannel.name,
          priority: Priority.high,
          importance: Importance.high,
        ),
      ),
    );
  }
}
