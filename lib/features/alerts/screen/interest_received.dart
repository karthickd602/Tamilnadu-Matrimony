import 'package:tamilnadu_matrimony/features/alerts/controller/alert_interest_send_controller.dart';

import '../../../common/widgets/loaders/animation_loader.dart';
import '../../../utils/constants/path_provider.dart';
import 'widget/interest_user_card.dart';

class InterestReceived extends StatelessWidget {
  const InterestReceived({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AlertInterestSendController.instance;

    return RefreshIndicator(
      onRefresh: () => controller.fetchAlertReceiveProfile(),

      child: Obx(() {
        if (controller.isReceiveAlertLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.receiveAlertProfileModel.isEmpty) {
          return TAnimationLoaderWidget(
            animation: TImages.noDataFoundAnimation,
            text: 'No receive Interest send Found',
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.receiveAlertProfileModel.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: TSizes.sm),
          itemBuilder: (context, index) {
            final alert = controller.receiveAlertProfileModel[index];
            return InterestUserCard(isReceived: true, alertProfileModel: alert);
          },
        );
      }),
    );
  }
}
