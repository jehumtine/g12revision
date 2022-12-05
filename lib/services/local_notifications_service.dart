// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:transcendedinstitute/screens/notification_screen.dart';

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static void initialize() {
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: AndroidInitializationSettings(
//                 '@drawable/app_notification_icon'));

   
//     _notificationsPlugin.initialize(initializationSettings,
//         onDidReceiveBackgroundNotificationResponse: (payload) {
//       Get.to(() => const NotificationScreen());
//     });
//   }

//   static void display(message) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

//       const NotificationDetails notificationDetails = NotificationDetails(
//           android: AndroidNotificationDetails(
//         'Transcended_channel',
//         'Transcended_channel',
//         importance: Importance.max,
//         priority: Priority.high,
//       ));

//       await _notificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//         payload: message.data["notification screen"],
//       );
//     } on Exception catch (e) {
//       // print(e);
//     }
//   }
// }
