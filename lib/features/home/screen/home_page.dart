import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';
import 'package:tamilnadu_matrimony/features/home/controller/dashboard_controller.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import '../../../common/widgets/loaders/animation_loader.dart';
import 'widget/customer_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      backgroundColor: TColors.scaffoldColor,
      appBar: TAppBar(
        title: TTexts.appName.tr,
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(TRoutes.filter);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.filter_alt_outlined,
                  size: TSizes.iconMd,
                  color: TColors.primary,
                ),
                const SizedBox(width: TSizes.xs / 2),
                Text(
                  TTexts.filter.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(width: TSizes.xs),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if(controller.isFirstLoad.value){
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.dashboardCustomerList.isEmpty) {
                    return Center(
                      child: TAnimationLoaderWidget(
                        animation: TImages.noDataFoundAnimation,
                        text: 'No Data Found',
                      ),
                    );
                  }
                  return ListView.separated(
                          controller: controller.scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              controller.dashboardCustomerList.length +
                              (controller.hasMore.value ? 1 : 0),
                          separatorBuilder: (_, i) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            if (index ==
                                controller.dashboardCustomerList.length) {
                              // Pagination Loader
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final customer =
                                controller.dashboardCustomerList[index];
                            return CustomerCard(customerProfile: customer);
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
