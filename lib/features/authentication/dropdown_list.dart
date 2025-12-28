import 'package:get/get.dart';

import '../../utils/constants/text_strings.dart';

/// -------------------- HEIGHT --------------------
class HeightOption {
  final int id;
  final String label;

  HeightOption({required this.id, required this.label});
}

class ChildCountModel {
  final String id;
  final String label;

  ChildCountModel({required this.id, required this.label});
}

class ProfileDropdowns {
  /// Height list
  static final List<HeightOption> heightList = [
    HeightOption(id: 0, label: "4ft (121 cm)"),
    HeightOption(id: 1, label: "4ft 1in (124 cm)"),
    HeightOption(id: 2, label: "4ft 2in (127 cm)"),
    HeightOption(id: 3, label: "4ft 3in (129 cm)"),
    HeightOption(id: 4, label: "4ft 4in (132 cm)"),
    HeightOption(id: 5, label: "4ft 5in (134 cm)"),
    HeightOption(id: 6, label: "4ft 6in (137 cm)"),
    HeightOption(id: 7, label: "4ft 7in (139 cm)"),
    HeightOption(id: 8, label: "4ft 8in (142 cm)"),
    HeightOption(id: 9, label: "4ft 9in (144 cm)"),
    HeightOption(id: 10, label: "4ft 10in (147 cm)"),
    HeightOption(id: 11, label: "4ft 11in (149 cm)"),
    HeightOption(id: 12, label: "5ft (152 cm)"),
    HeightOption(id: 13, label: "5ft 1in (154 cm)"),
    HeightOption(id: 14, label: "5ft 2in (157 cm)"),
    HeightOption(id: 15, label: "5ft 3in (160 cm)"),
    HeightOption(id: 16, label: "5ft 4in (162 cm)"),
    HeightOption(id: 17, label: "5ft 5in (165 cm)"),
    HeightOption(id: 18, label: "5ft 6in (167 cm)"),
    HeightOption(id: 19, label: "5ft 7in (170 cm)"),
    HeightOption(id: 20, label: "5ft 8in (172 cm)"),
    HeightOption(id: 21, label: "5ft 9in (175 cm)"),
    HeightOption(id: 22, label: "5ft 10in (177 cm)"),
    HeightOption(id: 23, label: "5ft 11in (180 cm)"),
    HeightOption(id: 24, label: "6ft (182 cm)"),
    HeightOption(id: 25, label: "6ft 1in (185 cm)"),
    HeightOption(id: 26, label: "6ft 2in (187 cm)"),
    HeightOption(id: 27, label: "6ft 3in (190 cm)"),
    HeightOption(id: 28, label: "6ft 4in (193 cm)"),
    HeightOption(id: 29, label: "6ft 5in (195 cm)"),
    HeightOption(id: 30, label: "6ft 6in (198 cm)"),
    HeightOption(id: 31, label: "6ft 7in (200 cm)"),
    HeightOption(id: 32, label: "6ft 8in (203 cm)"),
    HeightOption(id: 33, label: "6ft 9in (205 cm)"),
    HeightOption(id: 34, label: "6ft 10in (208 cm)"),
    HeightOption(id: 35, label: "6ft 11in (210 cm)"),
    HeightOption(id: 36, label: "7ft (213 cm)"),
  ];

  /// -------------------- CHILD COUNT --------------------
  static final List<ChildCountModel> childCountList = [
    ChildCountModel(id: '0', label: "0"),
    ChildCountModel(id: 'One', label: "1"),
    ChildCountModel(id: 'Two', label: "2"),
    ChildCountModel(id: 'Three', label: "3"),
    ChildCountModel(id: 'Four and above', label: "4 and above"),
  ];

  /// -------------------- RAASI --------------------
  static const List<String> raasiList = [
    "மேஷம்",
    "ரிஷபம்",
    "மிதுனம்",
    "கடகம்",
    "சிம்மம்",
    "கன்னி",
    "துலாம்",
    "விருச்சிகம்",
    "தனுசு",
    "மகரம்",
    "கும்பம்",
    "மீனம்",
  ];

  /// -------------------- DASA --------------------
  static const List<String> dasaList = [
    "சூரிய மகா திசை",
    "சந்திர மகா திசை",
    "செவ்வாய் மகா திசை",
    "புதன் மகா திசை",
    "வியாழ மகா திசை",
    "சுக்கிர மகா திசை",
    "சனி மகா திசை",
    "ராகு மகா திசை",
    "கேது மகா திசை",
    "குரு மகா திசை",
  ];

  /// -------------------- DHOSAM --------------------
  static const List<String> dhosamList = [
    "ராகு-கேது தோஷம்",
    "செவ்வாய் தோஷம்",
    "நாக தோஷம்",
    "கால சர்ப்ப தோஷம்",
    "களத்திர தோஷம்",
    "பித்ரு தோஷம்",
    "இதர தோஷம்",
  ];
  static List<String> martialStatusList = [
    TTexts.unMarried.tr,
    TTexts.widowed.tr,
    TTexts.divorced.tr,
    TTexts.separated.tr,
  ];
}
