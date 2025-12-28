import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../controller/subscription_controller.dart';

class ActiveSubscriptionPage extends StatelessWidget {
  ActiveSubscriptionPage({super.key});

  final controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: "Subscription", isBackButtonNeed: true),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Subscription Details",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              _buildRow("Status", controller.status),
              _buildRow("Package", controller.packageName),
              _buildRow("Issue Date", controller.buyDate),
              _buildRow("Credit's Left", controller.creditLeft),
              _buildRow(
                "Expiry Date",
                controller.expiryDate,
                trailing: Obx(
                  () => Text(
                    "(${controller.daysLeft.value})",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(TRoutes.buySubscription);

                    // Your upgrade logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Upgrade",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, RxString value, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 15)),
          Row(
            children: [
              Obx(
                () => Text(
                  value.value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (trailing != null) ...[const SizedBox(width: 5), trailing],
            ],
          ),
        ],
      ),
    );
  }
}
