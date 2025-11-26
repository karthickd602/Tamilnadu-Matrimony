import '../../../utils/constants/path_provider.dart';
import '../../home/screen/widget/customer_card.dart';
import '../controller/like_controller.dart';

class LikePage extends StatelessWidget {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LikeController());
    return  Column(
      children: [

        Expanded(
          child: Obx(
            ()=> ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.likeList.length,
              separatorBuilder: (_, i) =>
              const SizedBox(height: TSizes.spaceBtwItems),
              itemBuilder: (conte, index) {
                final customerProfile = controller.likeList[index];
                return CustomerCard(customerProfile: customerProfile,);
              },
            ),
          ),
        ),
      ],
    );
  }
}
