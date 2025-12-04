import 'package:tamilnadu_matrimony/features/favorites/controller/unlocked_controller.dart';

import '../../../common/widgets/loaders/animation_loader.dart';
import '../../../utils/constants/path_provider.dart';
import '../../home/screen/widget/customer_card.dart';

class UnlockedPage extends StatelessWidget {
  const UnlockedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UnlockedController());

    return RefreshIndicator(
      onRefresh: () => controller.fetchUnlockList(),

      child: Obx(() {
        if (controller.isUnlockLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.unlockList.isEmpty) {
          return TAnimationLoaderWidget(
            animation: TImages.noDataFoundAnimation,
            text: 'No unlock profile found',
          );
        }

        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 16),
          itemCount: controller.unlockList.length,
          separatorBuilder: (_, i) =>
              const SizedBox(height: TSizes.spaceBtwItems),
          itemBuilder: (_, index) {
            final customer = controller.unlockList[index];
            return CustomerCard(customerProfile: customer);
          },
        );
      }),
    );
  }
}
