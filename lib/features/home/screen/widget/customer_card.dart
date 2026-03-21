import '../../../../utils/constants/path_provider.dart';
import '../../controller/dashboard_controller.dart';
import '../../model/dashboard_list_model.dart';
import '../customer_view_page.dart';

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
                    width: double.infinity,
                    height: double.infinity,
                    margin: 0,
                    padding: 0,
                    borderRadius: 0,
                    imageType: ImageType.network,
                    image: customerProfile.image ?? '',
                    backgroundColor: TColors.white,
                    fit: BoxFit.fill,
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
                          "${customerProfile.name},${customerProfile.age}",
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          customerProfile.matriId.toString().toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Floating Share Button
                Positioned(
                  bottom: 100,
                  right: 20,
                  child: FloatingActionButton(
                    heroTag: null,
                    tooltip: 'Share',
                    onPressed: () {
                      controller.shareProfileFromList(customerProfile);
                    },
                    mini: true,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.share, color: TColors.primary),
                  ),
                ),

                // Floating Like Button
                Positioned(
                  bottom: 50,
                  right: 20,
                  child: Obx(
                    () => FloatingActionButton(
                      heroTag: null,
                      tooltip: 'Like',
                      onPressed: () {
                        controller.likeProfile(
                          profileId: customerProfile.id!,
                          likedValue: customerProfile.liked,
                        );
                      },
                      mini: true,
                      backgroundColor: Colors.white,
                      child: controller.isLikeLoading.value
                          ? const CircularProgressIndicator(color: Colors.red)
                          : customerProfile.liked.value == "yes"
                          ? const Icon(Icons.favorite, color: TColors.error)
                          : const Icon(
                              Icons.favorite_border,
                              color: TColors.error,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Chips and Action Buttons
          Container(
            color: TColors.white,
            padding: EdgeInsets.all(TSizes.xs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 2,
                  runSpacing: 6,
                  children: [
                    if (customerProfile.maritalStatus != null)
                      _buildChip(
                        Icons.join_inner_rounded,
                        customerProfile.maritalStatus ?? '',
                      ),
                    if (customerProfile.caste != null &&
                        customerProfile.caste!.isNotEmpty)
                      _buildChip(
                        Icons.auto_awesome,
                        customerProfile.caste ?? '',
                      ),
                    if (customerProfile.city != null)
                      _buildChip(Icons.location_on, customerProfile.city ?? ''),

                    if (customerProfile.moonSign != null &&
                        customerProfile.moonSign!.isNotEmpty)
                      _buildChip(
                        Icons.stars,
                        "Rasi: ${customerProfile.moonSign ?? ''}",
                      ),

                    if (customerProfile.star != null &&
                        customerProfile.star!.isNotEmpty)
                      _buildChip(Icons.star, customerProfile.star ?? ''),
                    if (customerProfile.occupation != null)
                      _buildChip(Icons.work, customerProfile.occupation ?? ''),
                    if (customerProfile.education != null &&
                        customerProfile.education!.isNotEmpty)
                      _buildChip(Icons.school, customerProfile.education ?? ''),
                    // if (customerProfile.educationDetails != null &&
                    //     customerProfile.educationDetails!.isNotEmpty)
                    //   _buildChip(
                    //     Icons.history_edu,
                    //     customerProfile.educationDetails ?? '',
                    //   ),
                    if (customerProfile.annualIncome != null &&
                        customerProfile.annualIncome!.isNotEmpty &&
                        customerProfile.annualIncome != "இல்லை")
                      _buildChip(
                        Icons.currency_rupee,
                        "Income: ${customerProfile.annualIncome}",
                      ),
                    if (customerProfile.viewedDate != null &&
                        customerProfile.viewedDate!.isNotEmpty)
                      _buildChip(
                        Icons.date_range,
                        "Unlocked Date: ${customerProfile.viewedDate}",
                      ),
                    if (customerProfile.doshamType != null &&
                        customerProfile.doshamType!.isNotEmpty)
                      _buildChip(
                        Icons.error_outline,
                        "Dosham: ${customerProfile.doshamType}",
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        debugPrint(
                          "CustomerCard isUnlocked: ${customerProfile.isUnlocked}",
                        );
                        debugPrint(
                          "CustomerCard isUnlocked: ${customerProfile.name}",
                        );

                        return ElevatedButton.icon(
                          onPressed: () {
                            controller.unlockProfile(
                              profileId: customerProfile.id ?? 0,
                              unlockValue: customerProfile.isUnlocked,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: TColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 3,
                          ),
                          icon: Icon(
                            customerProfile.isUnlocked.toLowerCase() == "true"
                                ? Icons.lock_open_outlined
                                : Icons.lock_outline,
                            color: Colors.white,
                          ),
                          label: Text(
                            customerProfile.isUnlocked.toLowerCase() == "true"
                                ? TTexts.viewDetails.tr
                                : TTexts.unlockNumber.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        await controller.fetchCustomerPage(
                          customerProfile.id ?? 0,
                        );
                        // controller.fetchCustomerPage(customerProfile.id??0);
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
        color: Colors.black.withValues(alpha: 0.08),
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
