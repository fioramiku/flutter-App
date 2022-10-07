import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';

import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
/*
class NotificationService {
  NotificationService();

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_notifications_active');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveLocalNotification);
  }

  void selectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      behaviorSubject.add(payload);
    }
  }

  Future<NotificationDetails> _notificationDetials() async {
    AndroidNotificationDetails androidnotificationdetials =
        AndroidNotificationDetails('channelId', 'channelName',
            channelDescription: 'description',
            priority: Priority.max,
            playSound: true,
            importance: Importance.max);

    return NotificationDetails(android: androidnotificationdetials);
  }

  void onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page

    print("$title");
  }
}
*/