import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';
import 'package:tamilnadu_matrimony/common/widgets/images/t_rounded_image.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import 'profile_detail_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: TTexts.homeTitle.tr,
        actions: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const Icon(Icons.filter_alt_outlined),
                const SizedBox(width: TSizes.xs),
                Text(TTexts.filter.tr),
                const SizedBox(width: TSizes.xs),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(TSizes.defaultSpace),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: 21,
            separatorBuilder: (_, i) =>
            const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (conte, index) {
              return InkWell(
                onTap: ()=>Get.to(()=>ProfileDetailsPage()),
                child: TRoundedContainer(
                  radius: 16,
                  padding: const EdgeInsets.all(TSizes.sm),
                  showShadow: true,
                  showBorder: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Image
                      Stack(
                        children: [
                          TRoundedImage(
                            margin: 0,
                            padding: 0,
                            imageType: ImageType.asset,
                            width: double.infinity,
                            height: 220,
                            image: TImages.sampleUser,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: TRoundedContainer(
                              padding: const EdgeInsets.all(TSizes.xs),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.verified,
                                    color: TColors.green,
                                    size: TSizes.iconSm,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    TTexts.verified.tr,
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Profile Info
                      Text(
                        "Karthick, 27".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Muslim | Lebbai", // <- can also be translated if needed
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 18, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            "Madurai", // <- location can also be translated dynamically
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey[600]),
                          ),
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
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              icon:
                              const Icon(Icons.call, color: Colors.white),
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
                              radius: 12,
                              backgroundColor:
                              TColors.primary.withValues(alpha: 0.1),
                              child: const Icon(
                                Icons.arrow_right_alt_rounded,
                                color: TColors.primary,
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
