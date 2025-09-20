import 'package:tamilnadu_matrimony/common/widgets/appbar/appbar.dart';

import '../../../utils/constants/path_provider.dart';

class UnlockPage extends StatelessWidget {
  const UnlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: 'Tamil Matrimony'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            Text("Unlock")
          ]),
        ),
      ),
    );
  }
}
