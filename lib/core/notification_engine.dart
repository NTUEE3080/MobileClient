import 'package:coursecupid/auth/lib/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../auth/frame.dart';
import 'notification.dart';

Future _backgroundHandler(RemoteMessage message) async {
  logger.i("Handling a background message: ${message.messageId}");
  var n = _toDomain(message);
  // Write actual background controller here
}

class NotificationService {
  late NotificationDaemon daemon;
  AuthMetaUser user;

  NotificationService(this.user);

  updateUser(AuthMetaUser user) {
    this.user = user;
  }

  Icon toIcon(String s) {
    switch (s) {
      case "info":
        return const Icon(Icons.info);
      case "notification":
        return const Icon(Icons.notifications);
      case "warning":
        return const Icon(Icons.warning);
      case "error":
        return const Icon(Icons.error);
      case "idea":
        return const Icon(Icons.lightbulb);
      case "announcement":
        return const Icon(Icons.announcement);
      case "release":
        return const Icon(Icons.new_releases);
      case "privacy":
        return const Icon(Icons.privacy_tip);
      default:
        return const Icon(Icons.email);
    }
  }

  Future init(BuildContext context) async {
    var t = Theme.of(context);
    var cs = t.colorScheme;
    daemon = NotificationDaemon(
        // initial handler
        (message) async {
      if (message.targetAud == "all" ||
          user.tokenData?.sub == message.targetAud) {
        showSimpleNotification(
          Text(message.dataTitle ?? message.title ?? "Unknown Title"),
          leading: toIcon(message.icon ?? ""),
          subtitle: Text(message.dataBody ?? message.body ?? "Unknown Message"),
          background: cs.primary.withAlpha(0x88),
          duration: const Duration(seconds: 10),
        );
      }
    },
        // inApp Handler
        (message) async {
      if (message.targetAud == "all" ||
          user.tokenData?.sub == message.targetAud) {
        showSimpleNotification(
          Text(message.dataTitle ?? message.title ?? "Unknown Title"),
          leading: toIcon(message.icon ?? ""),
          subtitle: Text(message.dataBody ?? message.body ?? "Unknown Message"),
          background: cs.primary.withAlpha(0x88),
          duration: const Duration(seconds: 10),
        );
      }
    },
        // open handler
        (message) async {
      if (message.targetAud == "all" ||
          user.tokenData?.sub == message.targetAud) {}
    });
    await daemon.init();
  }
}

typedef PushNotificationHandler = Future Function(PushNotification message);

class NotificationDaemon {
  final PushNotificationHandler initialHandler;
  final PushNotificationHandler inAppHandler;
  final PushNotificationHandler onOpenHandler;

  NotificationDaemon(
      this.initialHandler, this.inAppHandler, this.onOpenHandler);

  Future init() async {
    await _checkForInitialMessage();
    _registerNotification();
  }

  _checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await _initialMessageHandler(initialMessage);
    }
  }

  Future _initialMessageHandler(RemoteMessage message) async {
    logger.i("Handling a initial message: ${message.messageId}");
    var n = _toDomain(message);
    await initialHandler(n);
  }

  Future _inAppHandler(RemoteMessage message) async {
    logger.i("Handling a in-app message: ${message.messageId}");
    var n = _toDomain(message);
    await inAppHandler(n);
  }

  Future _onOpenHandler(RemoteMessage message) async {
    logger.i("Handling on open message: ${message.messageId}");
    var n = _toDomain(message);
    await onOpenHandler(n);
  }

  void _registerNotification() async {
    await Firebase.initializeApp();
    var _messaging = FirebaseMessaging.instance;
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      logger.i("registering handlers...");
      FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
      FirebaseMessaging.onMessage.listen(_inAppHandler);
      FirebaseMessaging.onMessageOpenedApp.listen(_onOpenHandler);
      logger.i("handlers registered!");
    } else {
      logger.i('User declined or has not accepted permission');
    }
  }
}

PushNotification _toDomain(RemoteMessage rm) {
  return PushNotification(
    title: rm.notification?.title,
    body: rm.notification?.body,
    dataTitle: rm.data['title'] ?? "Unknown Title",
    dataBody: rm.data['body'] ?? "Unknown Body",
    type: rm.data['type'] ?? "",
    targetAud: rm.data['target'] ?? "all",
    icon: rm.data["icon"],
  );
}
