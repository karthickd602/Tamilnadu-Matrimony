import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import 'profile_detail_screen.dart';
import 'widget/customer_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black.withValues(alpha: 0.12),
      backgroundColor: TColors.bottomNavColor2,
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
          child: Column(
            children: [

              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 21,
                  separatorBuilder: (_, i) =>
                  const SizedBox(height: TSizes.spaceBtwItems),
                  itemBuilder: (conte, index) {
                    return CustomerCard();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
