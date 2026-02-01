import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';
import 'package:tamilnadu_matrimony/common/widgets/loaders/animation_loader.dart';
import 'package:tamilnadu_matrimony/features/home/controller/filter_controller.dart';
import 'package:tamilnadu_matrimony/features/home/screen/widget/customer_card.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

class SpecialFilterPage extends StatelessWidget {
  const SpecialFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController());

    return Scaffold(
      // backgroundColor: Colors.grey.shade50,
      appBar: const TAppBar(title: "Special Filters", isBackButtonNeed: true),
      body: SafeArea(
        child: Column(
          children: [
            /// -----------------------------------------------------------------
            /// 1. PROFESSIONAL FILTER GRID (Top Section)
            /// -----------------------------------------------------------------
            TRoundedContainer(
              // padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
              ),
              showBorder: true,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: const BorderRadius.only(
              //     bottomLeft: Radius.circular(20),
              //     bottomRight: Radius.circular(20),
              //   ),
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.black.withOpacity(0.04),
              //       blurRadius: 10,
              //       offset: const Offset(0, 4),
              //     ),
              //   ],
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 3.8, // Adjust for width/height ratio
                    children: [
                      _buildFilterCard(
                        controller,
                        "Second Marriage",
                        "unmarried",
                        Icons.favorite_outline_rounded,
                      ),
                      _buildFilterCard(
                        controller,
                        "No Caste",
                        "no_caste",
                        Icons.diversity_3_outlined,
                      ),
                      _buildFilterCard(
                        controller,
                        "Diff. Abled",
                        "disable_person",
                        Icons.accessible_forward_rounded,
                      ),
                      _buildFilterCard(
                        controller,
                        "Dosham",
                        "dhosam_having",
                        Icons.stars_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// -----------------------------------------------------------------
            /// 2. RESULTS BODY
            /// -----------------------------------------------------------------
            Expanded(
              child: Obx(() {
                // LOADING STATE
                if (controller.isSpecialLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                // EMPTY SELECTION STATE
                if (controller.selectedSpecialCategory.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.touch_app_outlined,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Tap a category to explore",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                // NO DATA FOUND
                if (controller.specialFilterProfiles.isEmpty) {
                  return Center(
                    child: SingleChildScrollView(
                      child: TAnimationLoaderWidget(
                        animation: TImages.noDataFoundAnimation,
                        text: 'No Matching Profiles Found',
                      ),
                    ),
                  );
                }

                // RESULTS LIST
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  itemCount: controller.specialFilterProfiles.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final customer = controller.specialFilterProfiles[index];
                    return CustomerCard(customerProfile: customer);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// -----------------------------------------------------------------
  /// FILTER CARD WIDGET
  /// -----------------------------------------------------------------
  Widget _buildFilterCard(
    FilterController controller,
    String label,
    String type,
    IconData icon,
  ) {
    return Obx(() {
      final isSelected = controller.selectedSpecialCategory.value == type;
      final primaryColor = TColors.primary;

      return InkWell(
        onTap: () => controller.setSpecialFilter(type),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withOpacity(0.08) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? primaryColor : Colors.grey.shade600,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected ? primaryColor : Colors.grey.shade800,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
