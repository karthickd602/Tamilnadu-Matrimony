import 'package:get/get.dart';

class CustomerUserModel {
  int id;
  String matriId;
  String name;
  String age;
  String occupation;
  String educationDetails;
  String moonSign;
  String star;
  String city;
  String state;
  String religion;
  String maritalStatus;
  String dob;
  String inLaknam;
  String caste;
  String photo1;
  String photo1Approve;
  String complexion;
  String height;
  String fatherName;
  String fathersOccupation;
  String motherName;
  String mothersOccupation;
  String noOfBrothers;
  String noOfSisters;
  String expectations;
  String speCases;
  String doshamType;
  String address;
  String mobile;
  String phone;
  bool isUnlocked;
  String horosApprove;
  String horosCheck;
  RxString liked = "no".obs;
  String verified;
  Map<int, String> rasi;
  Map<int, String> amsam;

  CustomerUserModel({
    required this.id,
    required this.matriId,
    required this.name,
    required this.age,
    required this.occupation,
    required this.educationDetails,
    required this.moonSign,
    required this.star,
    required this.city,
    required this.state,
    required this.religion,
    required this.maritalStatus,
    required this.dob,
    required this.inLaknam,
    required this.caste,
    required this.photo1,
    required this.photo1Approve,
    required this.complexion,
    required this.height,
    required this.fatherName,
    required this.fathersOccupation,
    required this.motherName,
    required this.mothersOccupation,
    required this.noOfBrothers,
    required this.noOfSisters,
    required this.expectations,
    required this.speCases,
    required this.doshamType,
    required this.address,
    required this.mobile,
    required this.phone,
    required this.isUnlocked,
    required this.horosApprove,
    required this.horosCheck,
    String? liked,
    required this.verified,
    required this.rasi,
    required this.amsam,
  }) {
    this.liked.value = liked ?? "no";
  }

  /// 🔥 Empty Model
  factory CustomerUserModel.empty() {
    return CustomerUserModel(
      id: 0,
      matriId: "",
      name: "",
      age: "",
      occupation: "",
      educationDetails: "",
      moonSign: "",
      star: "",
      city: "",
      state: "",
      religion: "",
      maritalStatus: "",
      dob: "",
      inLaknam: "",
      caste: "",
      photo1: "",
      photo1Approve: "",
      complexion: "",
      height: "",
      fatherName: "",
      fathersOccupation: "",
      motherName: "",
      mothersOccupation: "",
      noOfBrothers: "",
      noOfSisters: "",
      expectations: "",
      speCases: "",
      doshamType: "",
      address: "",
      mobile: "",
      phone: "",
      isUnlocked: false,
      horosApprove: "",
      horosCheck: "",
      liked: "no",
      verified: "",
      rasi: {},
      amsam: {},
    );
  }

  /// 🔄 JSON → Model
  factory CustomerUserModel.fromJson(Map<String, dynamic> json) {
    return CustomerUserModel(
      id: json["ID"] ?? 0,
      matriId: json["MatriID"] ?? "",
      name: json["Name"] ?? "",
      age: json["Age"]?.toString() ?? "",
      occupation: json["Occupation"] ?? "",
      educationDetails: json["EducationDetails"] ?? "",
      moonSign: json["Moonsign"] ?? "",
      star: json["Star"] ?? "",
      city: json["City"] ?? "",
      state: json["State"] ?? "",
      religion: json["Religion"] ?? "",
      maritalStatus: json["Maritalstatus"] ?? "",
      dob: json["DOB"] ?? "",
      inLaknam: json["InLaknam"] ?? "",
      caste: json["Caste"] ?? "",
      photo1: json["photo1"] ?? "",
      photo1Approve: json["Photo1Approve"] ?? "",
      complexion: json["Complexion"] ?? "",
      height: json["Height"] ?? "",
      fatherName: json["Fathername"] ?? "",
      fathersOccupation: json["Fathersoccupation"] ?? "",
      motherName: json["Mothersname"] ?? "",
      mothersOccupation: json["Mothersoccupation"] ?? "",
      noOfBrothers: json["noofbrothers"]?.toString() ?? "",
      noOfSisters: json["noofsisters"]?.toString() ?? "",
      expectations: json["expections"] ?? "",
      speCases: json["spe_cases"] ?? "",
      doshamType: json["thoosamtype"] ?? "",
      address: json["address"] ?? "",
      mobile: json["mobile"] ?? "",
      phone: json["phone"] ?? "",
      isUnlocked: json["is_unlocked"].toString() == "true",
      horosApprove: json["HorosApprove"]?.toString() ?? "",
      horosCheck: json["Horoscheck"]?.toString() ?? "",
      liked: json["liked"] ?? "no",
      verified: json["verified"] ?? "",
      rasi: {
        0: json["r12"] ?? "", // Pisces
        1: json["r1"] ?? "", // Aries
        2: json["r2"] ?? "",
        3: json["r3"] ?? "",
        4: json["r4"] ?? "",
        5: json["r5"] ?? "",
        6: json["r6"] ?? "",
        7: json["r7"] ?? "",
        8: json["r8"] ?? "",
        9: json["r9"] ?? "",
        10: json["r10"] ?? "",
        11: json["r11"] ?? "",
      },
      amsam: {
        0: json["a12"] ?? "",
        1: json["a1"] ?? "",
        2: json["a2"] ?? "",
        3: json["a3"] ?? "",
        4: json["a4"] ?? "",
        5: json["a5"] ?? "",
        6: json["a6"] ?? "",
        7: json["a7"] ?? "",
        8: json["a8"] ?? "",
        9: json["a9"] ?? "",
        10: json["a10"] ?? "",
        11: json["a11"] ?? "",
      },
    );
  }
}
