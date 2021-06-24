import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:strong_delivery/screens/auth/client/login_screen.dart';
import 'package:strong_delivery/screens/auth/livreure/login_screen.dart';
import 'package:strong_delivery/models/MessageArguments.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Space extends StatefulWidget {
  Space({Key key}) : super(key: key);

  @override
  _SpaceState createState() => _SpaceState();
}

Future<void> init() async {
  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  var androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
  var initializationSettings = InitializationSettings(
      android: androidSettings, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

class _SpaceState extends State<Space> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      await Firebase.initializeApp();
      print("Handling a background message: ${message.messageId}");
      Navigator.pushNamed(context, '/notif',
          arguments: MessageArguments(message, true));
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id, channel.name, channel.description,
                  icon: '@mipmap/ic_launcher'),
            ));
        Navigator.pushNamed(context, '/notif',
            arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print("Handling a onMessageOpenedApp message: ${message.messageId}");
      Navigator.pushNamed(context, '/notif',
          arguments: MessageArguments(message, true));
    });
    init();
  }

  @override
  Widget build(BuildContext context) {
    Future onDidReceiveLocalNotification(
        int id, String title, String body, String payload) async {
      print(payload);
      print(body);
    }

// await Firebase.initializeApp();
//       print("Handling a background message: ${message.messageId}");
//       Navigator.pushNamed(context, '/notif',
//           arguments: MessageArguments(RemoteMessage(data: ), true));
// }
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Image.asset('assets/images/stronglogo.png', fit: BoxFit.cover),
        ),
        elevation: 0.0,
      ),
      body: Row(
        children: [
          Container(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              // color: Colors.greenAccent,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/lion.png",
                      height: 170.0,
                      width: 170.0,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "JE SUIS :",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Get.to(LoginClient());
                          },
                          child: Text(
                            'Client',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w900,
                                fontSize: 24.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Get.to(LoginLivreure());
                          },
                          child: Text(
                            'Livreur',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 22.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class Space extends StatelessWidget {
//   const Space({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Theme.of(context).primaryColor,
//     appBar: AppBar(
//       leading: Padding(
//         padding: const EdgeInsets.only(left: 8.0, top: 8.0),
//         child: Image.asset('assets/images/stronglogo.png', fit: BoxFit.cover),
//       ),
//       elevation: 0.0,
//     ),
//     body: Row(
//       children: [
//         Container(
//           height: 10.0,
//         ),
//         Expanded(
//           child: Container(
//             // color: Colors.greenAccent,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 40.0),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     "assets/images/lion.png",
//                     height: 170.0,
//                     width: 170.0,
//                   ),
//                   SizedBox(
//                     height: 16.0,
//                   ),
//                   Text(
//                     "JE SUIS :",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 40.0,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 16.0,
//                   ),
//                   Container(
//                     margin:
//                         EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 40,
//                       child: RaisedButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(30.0)),
//                         ),
//                         color: Colors.white,
//                         onPressed: () {
//                           Get.to(LoginClient());
//                         },
//                         child: Text(
//                           'Client',
//                           style: TextStyle(
//                               color: Colors.black87,
//                               fontWeight: FontWeight.w900,
//                               fontSize: 24.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin:
//                         EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 40,
//                       child: RaisedButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(30.0)),
//                         ),
//                         color: Theme.of(context).primaryColor,
//                         onPressed: () {
//                           Get.to(LoginLivreure());
//                         },
//                         child: Text(
//                           'Livreur',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w900,
//                               fontSize: 22.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
// }

// class Space extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 8.0, top: 8.0),
//           child: Image.asset('assets/images/stronglogo.png', fit: BoxFit.cover),
//         ),
//         elevation: 0.0,
//       ),
//       body: Row(
//         children: [
//           Container(
//             height: 10.0,
//           ),
//           Expanded(
//             child: Container(
//               // color: Colors.greenAccent,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 40.0),
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/images/lion.png",
//                       height: 170.0,
//                       width: 170.0,
//                     ),
//                     SizedBox(
//                       height: 16.0,
//                     ),
//                     Text(
//                       "JE SUIS :",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 40.0,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16.0,
//                     ),
//                     Container(
//                       margin:
//                           EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: 40,
//                         child: RaisedButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(30.0)),
//                           ),
//                           color: Colors.white,
//                           onPressed: () {
//                             Get.to(LoginClient());
//                           },
//                           child: Text(
//                             'Client',
//                             style: TextStyle(
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 24.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin:
//                           EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: 40,
//                         child: RaisedButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(30.0)),
//                           ),
//                           color: Theme.of(context).primaryColor,
//                           onPressed: () {
//                             Get.to(LoginLivreure());
//                           },
//                           child: Text(
//                             'Livreur',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w900,
//                                 fontSize: 22.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
