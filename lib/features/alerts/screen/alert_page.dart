import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/tab/custom_tab_bar.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text_strings.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = TColors.primary;

    return KTabBarPage(
      title: TTexts.alerts.tr,
      tabs: [
        Tab(
          icon: Icon(Icons.notifications_none, color: primaryColor),
          text: TTexts.notification.tr,
        ),
        Tab(
          icon: Icon(Icons.send_outlined, color: primaryColor),
          text: TTexts.interestSent.tr,
        ),
        Tab(
          icon: Icon(Icons.inbox_outlined, color: primaryColor),
          text: TTexts.interestReceived.tr,
        ),
      ],
      tabViews: const [
        Center(child: Text("Notification")),
        Center(child: Text("Interest Sent")),
        Center(child: Text("Interest Received")),
      ],
    );
  }
}
