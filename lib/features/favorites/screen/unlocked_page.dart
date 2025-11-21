import '../../../utils/constants/path_provider.dart';

class UnlockedPage extends StatelessWidget {
  const UnlockedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 2,
            separatorBuilder: (_, i) =>
            const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (conte, index) {
              // return CustomerCard();
            },
          ),
        ),
      ],
    );
  }
}
