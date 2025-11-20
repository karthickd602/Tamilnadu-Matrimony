import 'package:tamilnadu_matrimony/utils/constants/path_provider.dart';

import '../../../controller/language/language_selection_controller.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LanguageController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // 🔹 Title
            Text(
              TTexts.selectLanguage.tr, // translation key
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            // 🔹 Language Options
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLangCard(
                    title: "English",
                    letter: "A",
                    isSelected: c.selectedLang.value == "en",
                    onTap: () => c.changeLanguage("en"),
                    context: context
                  ),
                  const SizedBox(width: 20),
                  _buildLangCard(
                    title: "தமிழ்",
                    letter: "அ",
                    isSelected: c.selectedLang.value == "ta",
                    onTap: () => c.changeLanguage("ta"),
                      context: context
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 🔹 Continue Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Get.toNamed(TRoutes.bottomNav);
                    Get.toNamed(TRoutes.loginPage);
                  },
                  child: Text(
                    TTexts.continueText.tr, // use translation key
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLangCard({
    required String title,
    required String letter,
    required bool isSelected,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: TRoundedContainer(
        width: 125,
        height: 125,
        padding: EdgeInsets.all(TSizes.xs),
        showBorder: true,
        borderColor: isSelected ? TColors.green : Colors.grey.shade300,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              letter,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: isSelected
                    ? Colors.blue
                    : (THelperFunctions.isDarkMode(context))
                          ? Colors.white
                          : TColors.black,
                fontSize: 40,
              ),

              // style: TextStyle(
              //   fontSize: 40,
              //   fontWeight: FontWeight.bold,
              //   color: isSelected ? Colors.blue : Colors.black,
              // )
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(Get.context!).textTheme.titleMedium!.apply(
                color: isSelected ? TColors.green :(THelperFunctions.isDarkMode(context))
                    ? Colors.white
                    : TColors.black,
              ),
              // style: TextStyle(
              //   fontSize: 16,
              //   color: isSelected ? TColors.green : Colors.black,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
