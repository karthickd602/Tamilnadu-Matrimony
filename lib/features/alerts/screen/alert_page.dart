import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamilnadu_matrimony/features/alerts/screen/interest_send.dart';

import '../../../common/widgets/tab/custom_tab_bar.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text_strings.dart';
import '../controller/alert_interest_send_controller.dart';
import 'interest_received.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(AlertInterestSendController());


    return KTabBarPage(
      title: TTexts.alerts.tr,
      tabs: [
        Tab(
          icon: Icon(Icons.notifications_none, color: TColors.primary),
          text: TTexts.notification.tr,
        ),
        Tab(
          icon: Icon(Icons.send_outlined, color: TColors.primary),
          text: TTexts.interestSent.tr,
        ),
        Tab(
          icon: Icon(Icons.inbox_outlined, color: TColors.primary),
          text: TTexts.interestReceived.tr,
        ),
      ],
      tabViews: const [
        Center(child: Text("Notification")),
        InterestSend(),
        InterestReceived()
      ],
    );
  }
}
