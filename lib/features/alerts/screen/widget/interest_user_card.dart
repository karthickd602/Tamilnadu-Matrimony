import 'package:tamilnadu_matrimony/features/alerts/model/alert_profile_model.dart';

import '../../../../utils/constants/path_provider.dart';

class InterestUserCard extends StatelessWidget {
  const InterestUserCard({
    super.key, required this.isReceived, required this.alertProfileModel,
  });
final bool isReceived;
final AlertProfileModel alertProfileModel;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Profile Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TRoundedImage(
                padding: 0,
                imageType: ImageType.network,
                image: alertProfileModel.photo1,
                height: 100,
                width: 100,
              ),
              const SizedBox(width: TSizes.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alertProfileModel.name,
                      style:
                      Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Married",
                      style:
                      Theme.of(context).textTheme.bodyMedium,
                    ),       Text(
                      "${alertProfileModel.age} yrs • ${alertProfileModel.height} • ${alertProfileModel.caste} • ${alertProfileModel.educationDetails}",
                      style:
                      Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      alertProfileModel.occupation,
                      style:
                      Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      alertProfileModel.city,
                      style:
                      Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.sm),

          /// Interest Info
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: isReceived?"Received interest from her":"You sent her an interest",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: " - ${THelperFunctions.formatDateString(alertProfileModel.eisentdt)}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
