import 'package:flutter/material.dart';
import '../../../utils/constants/path_provider.dart';
import 'widget/interest_user_card.dart';

class InterestSend extends StatelessWidget {
  const InterestSend({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            separatorBuilder: (context, index) =>
            const SizedBox(height: TSizes.sm),
            itemBuilder: (context, index) {
              return InterestUserCard(isReceived: false,);
            },
          ),
        ],
      ),
    );
  }
}

