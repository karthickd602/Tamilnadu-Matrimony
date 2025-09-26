import '../../../../utils/constants/path_provider.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        border: Border.all(color: TColors.white,width: TSizes.sm),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Image
          TRoundedImage(
            margin: 0,
            padding: 0,
            borderRadius: TSizes.borderRadiusLg,
            imageType: ImageType.asset,
            image: TImages.sampleUser,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),

          // Verified Badge
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                  const Icon(Icons.verified, color: TColors.green, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    "Verified",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: TColors.green),
                  ),
                ],
              ),
            ),
          ),

          // Info Panel (Glassmorphic style)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ID & Name
                  Text(
                    "ID-TM0001",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white70),
                  ),
                  Text(
                    "Karthick, 28",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Marital Status
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Never Married",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Chips with icons
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _buildChip(Icons.auto_awesome, "Muslim, Lebbai"),
                      _buildChip(Icons.work, "Software Engineer"),
                      _buildChip(Icons.school, "B.E. CSE"),
                      _buildChip(Icons.stars, "Rasi: Mesham"),
                      _buildChip(Icons.star, "Ashwini"),
                      _buildChip(Icons.location_on, "Madurai"),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding:
                            const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: TColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 3,
                          ),
                          icon: const Icon(Icons.lock_outline, color: Colors.white),
                          label: Text(
                            TTexts.unlockNumber.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {},
                        child: TRoundedContainer(
                          height: 50,
                          width: 50,
                          radius: 14,
                          backgroundColor:
                          TColors.primary.withValues(alpha: 0.15),
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
          ),

          // Floating Like Button
          Positioned(
            bottom: 120,
            right: 20,
            child: FloatingActionButton(
              heroTag: "Like",
              tooltip: 'Like',
              onPressed: () {},
              mini: true,
              backgroundColor: Colors.white,
              child: Icon(Icons.favorite, color: TColors.error),
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
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
