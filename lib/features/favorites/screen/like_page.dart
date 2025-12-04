import '../../../common/widgets/loaders/animation_loader.dart';
import '../../../utils/constants/path_provider.dart';
import '../../home/screen/widget/customer_card.dart';
import '../controller/like_controller.dart';

class LikePage extends StatelessWidget {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LikeController());
    return  RefreshIndicator(
      onRefresh: (){
        return controller.fetchLikeList();
      },
      child: Obx(
        () {
          if(controller.isLikeLoading.value){
            return const Center(child: CircularProgressIndicator());
          }
          if(controller.likeList.isEmpty){
            return TAnimationLoaderWidget(
              animation: TImages.noDataFoundAnimation,
              text: 'No Like profile found',
            );
          }
          return ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.likeList.length,
          separatorBuilder: (_, i) =>
          const SizedBox(height: TSizes.spaceBtwItems),
          itemBuilder: (conte, index) {
            final customerProfile = controller.likeList[index];
            return CustomerCard(customerProfile: customerProfile,);
          },
        );
        },
      ),
    );
  }
}
