import '../../../../utils/constants/path_provider.dart';

class InterestUserCard extends StatelessWidget {
  const InterestUserCard({
    super.key, required this.isReceived,
  });
final bool isReceived;
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
                imageType: ImageType.asset,
                image: TImages.sampleUser1,
                height: 100,
                width: 100,
              ),
              const SizedBox(width: TSizes.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "N Arun Kumar (EMP0001)",
                      style:
                      Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "26 yrs • 5'2\" • Naidu • BCA",
                      style:
                      Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "Software Professional",
                      style:
                      Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "Chennai",
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
                  text: " - 18 Feb 25",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          const SizedBox(height: TSizes.sm),

          /// Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call),
                  label: const Text("Call Now"),
                ),
              ),
              const SizedBox(width: TSizes.sm),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                  label: const Text("Message"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
