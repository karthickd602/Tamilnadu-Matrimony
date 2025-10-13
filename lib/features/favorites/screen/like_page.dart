import '../../../utils/constants/path_provider.dart';
import '../../home/screen/widget/customer_card.dart';

class LikePage extends StatelessWidget {
  const LikePage({super.key});

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
              return CustomerCard();
            },
          ),
        ),
      ],
    );
  }
}
