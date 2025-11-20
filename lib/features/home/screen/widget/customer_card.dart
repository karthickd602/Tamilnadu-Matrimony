import '../../../../utils/constants/path_provider.dart';
import '../../controller/dashboard_controller.dart';
import '../../model/dashboard_list_model.dart';
import '../customer_card_view.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key, required this.customerProfile});

  final CustomerProfileListModel customerProfile;

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    return Container(
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: TColors.white, width: 5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: TRoundedImage(
                    margin: 0,
                    padding: 0,
                    borderRadius: 0,
                    imageType: ImageType.network,
                    image: customerProfile.image ?? '',
                    backgroundColor: TColors.white,
                    fit: BoxFit.cover,
                  ),
                ),

                // Verified Badge
                Positioned(
                  top: 20,
                  left: 20,
                  child: customerProfile.verified?.toLowerCase() == "yes"
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.verified,
                                color: TColors.green,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Verified",
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: TColors.green),
                              ),
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                ),

                // Info Panel (Glassmorphic style)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black.withValues(alpha: 0.4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          customerProfile.id.toString(),
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: Colors.white70),
                        ),
                        Text(
                          "${customerProfile.name},${customerProfile.age}",
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Floating Like Button
                Positioned(
                  bottom: 50,
                  right: 20,
                  child:Obx(() => FloatingActionButton(
                    heroTag: null,
                    tooltip: 'Like',
                    onPressed: () {
                      controller.likeProfile(customerProfile.id ?? 0);
                      customerProfile.liked.value = "yes";
                    },
                    mini: true,
                    backgroundColor: Colors.white,
                    child: customerProfile.liked.value == "yes"
                        ? Icon(Icons.favorite, color: TColors.error)
                        : Icon(Icons.favorite_border, color: TColors.error),
                  ))

                ),
              ],
            ),
          ),

          // Chips and Action Buttons
          Container(
            color: TColors.white,
            padding: EdgeInsets.all(TSizes.xs),
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _buildChip(
                      Icons.auto_awesome,
                      customerProfile.address ?? '',
                    ),
                    _buildChip(Icons.work, customerProfile.occupation ?? ''),
                    _buildChip(
                      Icons.school,
                      customerProfile.educationDetails ?? '',
                    ),
                    _buildChip(
                      Icons.stars,
                      "Rasi: ${customerProfile.moonSign ?? ''}",
                    ),
                    _buildChip(Icons.star, customerProfile.star ?? ''),
                    _buildChip(Icons.location_on, customerProfile.city ?? ''),
                    _buildChip(
                      Icons.join_inner_rounded,
                      customerProfile.maritalStatus ?? '',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: TColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 3,
                        ),
                        icon: const Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                        label: Text(
                          TTexts.unlockNumber.tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Get.to(() => CustomerDetailsView());
                      },
                      child: TRoundedContainer(
                        height: 50,
                        width: 50,
                        radius: 14,
                        backgroundColor: TColors.primary.withValues(
                          alpha: 0.15,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: TColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black, size: 16),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
