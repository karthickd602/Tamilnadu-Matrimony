import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';
import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import 'widget/customer_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.scaffoldColor,
      appBar: TAppBar(
        title: TTexts.appName.tr,
        actions: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const Icon(Icons.filter_alt_outlined,size: TSizes.iconMd,color: TColors.primary,),
                const SizedBox(width: TSizes.xs/2),
                Text(TTexts.filter.tr,style: Theme.of(context).textTheme.bodyLarge,),
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
