import '../../../common/widgets/loaders/animation_loader.dart';
import '../../../utils/constants/path_provider.dart';
import '../../home/controller/dashboard_controller.dart';
import '../../home/screen/customer_view_page.dart';
import '../controller/alert_interest_send_controller.dart';
import 'widget/interest_user_card.dart';

class InterestSend extends StatelessWidget {
  const InterestSend({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AlertInterestSendController());
    final dashboardController = DashboardController.instance;

    return RefreshIndicator(
      onRefresh: () => controller.fetchAlertSendProfile(),

      child: Obx(() {
        if (controller.isSendAlertLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.sendAlertProfileModel.isEmpty) {
          return TAnimationLoaderWidget(
            animation: TImages.noDataFoundAnimation,
            text: 'No send Interest send Found',
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.sendAlertProfileModel.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: TSizes.sm),
          itemBuilder: (context, index) {
            final sendAlert = controller.sendAlertProfileModel[index];

            return InkWell(
              onTap: () async {
                await dashboardController.fetchCustomerPage(sendAlert.id);
                Get.to(() => CustomerDetailsView());
              },
              child: InterestUserCard(
                isReceived: false,
                alertProfileModel: sendAlert,
              ),
            );
          },
        );
      }),
    );
  }
}
