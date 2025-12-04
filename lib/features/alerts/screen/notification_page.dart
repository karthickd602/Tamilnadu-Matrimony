import 'package:tamilnadu_matrimony/features/alerts/controller/notification_controller.dart';
import 'package:tamilnadu_matrimony/features/alerts/screen/widget/notification_card.dart';

import '../../../common/widgets/loaders/animation_loader.dart';
import '../../../utils/constants/path_provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    return RefreshIndicator(
      onRefresh: ()=>controller.getNotificationList(),
      child: Obx(
            () {
              if(controller.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }
              if(controller.notificationList.isEmpty){
                return   TAnimationLoaderWidget(
                  animation: TImages.noDataFoundAnimation,
                  text: 'No notification Found',
                );
              }
              return ListView.separated(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.notificationList.length,
              separatorBuilder: (context, index) =>
              const SizedBox(height: TSizes.sm),
              itemBuilder: (context, index) {
                final item = controller.notificationList[index];

                return NotificationCard(
                  title: item.title,
                  description: item.description,
                  date: item.createdAt,
                  // logo: response.anLogo,
                );                },
            );
            },
      ),
    );
  }
}
