import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void initNotifications() {
  void _handleNotificationReceived(OSNotification notification) {
    print('Titre: ${notification.payload.title}');
    print('Message: ${notification.payload.body}');
  }

  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init("f9ee07e9-f4e5-4e6b-8efb-66eaa38de026", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
  OneSignal.shared.setNotificationReceivedHandler(_handleNotificationReceived);
}

class MyNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('En attente de notifications...');
  }
}
