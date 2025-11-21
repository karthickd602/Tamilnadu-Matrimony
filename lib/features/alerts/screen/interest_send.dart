import '../../../utils/constants/path_provider.dart';
import '../controller/alert_interest_send_controller.dart';
import 'widget/interest_user_card.dart';

class InterestSend extends StatelessWidget {
  const InterestSend({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AlertInterestSendController());
    return RefreshIndicator(
      onRefresh: ()=>controller.fetchAlertSendProfile(),
      child: SingleChildScrollView(
        // padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(
          ()=> Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.sendAlertProfileModel.length,
                separatorBuilder: (context, index) =>
                const SizedBox(height: TSizes.sm),
                itemBuilder: (context, index) {
                  final sendAlert = controller.sendAlertProfileModel[index];

                  return InterestUserCard(isReceived: false, alertProfileModel: sendAlert,);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

