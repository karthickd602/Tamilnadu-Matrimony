import 'package:get/get.dart';

class CustomerProfileListModel {
  final int? id;
  final String? matriId;
  final String? name;
  final String? age;
  final String? address;
  final String? occupation;
  final String? educationDetails;
  final String? moonSign;
  final String? star;
  final String? city;
  final String? state;
  final String? religion;
  final String? maritalStatus;
  final String? dob;
  final String? inLaknam;
  final String? caste;
  final String? image;
  final String? photoApprove;
  final String? complexion;
  final String? height;
  final String? fatherName;
  final String? fatherOccupation;
  final String? motherName;
  final String? motherOccupation;
  final String? noOfBrothers;
  final String? noOfSisters;
  final String? horosApprove;
  final String? horosCheck;
  RxString liked = "no".obs;
  RxString isUnlocked = "false".obs;
  final String? verified;
  final String? annualIncome;
  final String? education;
  final String? doshamType;
  final String? viewedDate;

  CustomerProfileListModel({
    this.id,
    this.matriId,
    this.name,
    this.age,
    this.address,
    this.occupation,
    this.educationDetails,
    this.moonSign,
    this.star,
    this.city,
    this.state,
    this.religion,
    this.maritalStatus,
    this.dob,
    this.inLaknam,
    this.caste,
    this.image,
    this.photoApprove,
    this.complexion,
    this.height,
    this.fatherName,
    this.fatherOccupation,
    this.motherName,
    this.motherOccupation,
    this.noOfBrothers,
    this.noOfSisters,
    this.horosApprove,
    this.horosCheck,
    String? liked,
    String? isUnlocked,
    this.verified,
    this.annualIncome,
    this.education,
    this.doshamType,
    this.viewedDate,
  }) {
    this.liked.value = liked ?? "no";
    this.isUnlocked.value = isUnlocked ?? "false";
  }

  /// EMPTY MODEL
  factory CustomerProfileListModel.empty() {
    return CustomerProfileListModel(
      id: 0,
      matriId: "",
      name: "",
      age: "",
      address: "",
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
      image: "",
      photoApprove: "",
      complexion: "",
      height: "",
      fatherName: "",
      fatherOccupation: "",
      motherName: "",
      motherOccupation: "",
      noOfBrothers: "",
      noOfSisters: "",
      horosApprove: "",
      horosCheck: "",
      liked: '',
      isUnlocked: '',
      verified: "",
      annualIncome: "",
      education: "",
      doshamType: "",
      viewedDate: "",
    );
  }

  factory CustomerProfileListModel.fromJson(Map<String, dynamic> json) {
    return CustomerProfileListModel(
      id: json['ID'],
      matriId: json['MatriID']?.toString(),
      name: json['Name']?.toString(),
      age: json['Age']?.toString(),
      address: json['Address']?.toString(),
      occupation: json['Occupation']?.toString(),
      educationDetails: (json['EducationDetails'] ?? json['Education'])
          ?.toString(),
      education: json['Education']?.toString(),
      moonSign: json['Moonsign']?.toString(),
      star: json['Star']?.toString(),
      city: json['City']?.toString(),
      state: json['State']?.toString(),
      religion: json['Religion']?.toString(),
      maritalStatus: json['Maritalstatus']?.toString(),
      dob: json['DOB']?.toString(),
      inLaknam: json['InLaknam']?.toString(),
      caste: json['Caste']?.toString(),
      image: json['photo1']?.toString(),
      photoApprove: json['Photo1Approve']?.toString(),
      complexion: json['Complexion']?.toString(),
      height: json['Height']?.toString(),
      fatherName: json['Fathername']?.toString(),
      fatherOccupation: json['Fathersoccupation']?.toString(),
      motherName: json['Mothersname']?.toString(),
      motherOccupation: json['Mothersoccupation']?.toString(),
      noOfBrothers: json['noofbrothers']?.toString(),
      noOfSisters: json['noofsisters']?.toString(),
      horosApprove: json['HorosApprove']?.toString(),
      horosCheck: json['Horoscheck']?.toString(),
      liked: (json['liked'] ?? "no").toString(),
      isUnlocked: (json['is_unlocked'] ?? "false").toString(),
      verified: (json['verified'] ?? "no").toString(),
      annualIncome: json['Annualincome']?.toString(),
      doshamType: json['thoosamtype']?.toString(),
      viewedDate: json['viewed_date']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'MatriID': matriId,
      'Name': name,
      'Age': age,
      'Address': address,
      'Occupation': occupation,
      'EducationDetails': educationDetails,
      'Education': education,
      'Moonsign': moonSign,
      'Star': star,
      'City': city,
      'State': state,
      'Religion': religion,
      'Maritalstatus': maritalStatus,
      'DOB': dob,
      'InLaknam': inLaknam,
      'Caste': caste,
      'photo1': image,
      'Photo1Approve': photoApprove,
      'Complexion': complexion,
      'Height': height,
      'Fathername': fatherName,
      'Fathersoccupation': fatherOccupation,
      'Mothersname': motherName,
      'Mothersoccupation': motherOccupation,
      'noofbrothers': noOfBrothers,
      'noofsisters': noOfSisters,
      'HorosApprove': horosApprove,
      'Horoscheck': horosCheck,
      'liked': liked.value,
      'isUnlocked': isUnlocked.value,
      'verified': verified,
      'Annualincome': annualIncome,
      'thoosamtype': doshamType,
    };
  }
}
