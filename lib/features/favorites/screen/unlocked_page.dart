import 'package:tamilnadu_matrimony/features/favorites/controller/unlocked_controller.dart';

import '../../../utils/constants/path_provider.dart';
import '../../home/screen/widget/customer_card.dart';

class UnlockedPage extends StatelessWidget {
  const UnlockedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UnlockedController());
    return  Column(
      children: [

        Obx(
          ()=> Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.unlockList.length,
              separatorBuilder: (_, i) =>
              const SizedBox(height: TSizes.spaceBtwItems),
              itemBuilder: (conte, index) {
                final customerProfile = controller.unlockList[index];
                return CustomerCard(customerProfile:customerProfile ,);
              },
            ),
          ),
        ),
      ],
    );
  }
}
