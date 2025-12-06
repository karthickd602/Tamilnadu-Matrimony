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
  }) {
    this.liked.value = liked ?? "no";
    this.isUnlocked.value = isUnlocked ?? "false";
  }

  /// EMPTY MODEL
  factory CustomerProfileListModel.empty() {
    return  CustomerProfileListModel(
      id : 0,
      matriId : "",
      name : "",
      age : "",
      address : "",
      occupation : "",
      educationDetails : "",
      moonSign : "",
      star : "",
      city : "",
      state : "",
      religion : "",
      maritalStatus : "",
      dob : "",
      inLaknam : "",
      caste : "",
      image : "",
      photoApprove : "",
      complexion : "",
      height : "",
      fatherName : "",
      fatherOccupation : "",
      motherName : "",
      motherOccupation : "",
      noOfBrothers : "",
      noOfSisters : "",
      horosApprove : "",
      horosCheck : "",
      liked:'',
      isUnlocked:'',
      verified : "",
    );
  }

  factory CustomerProfileListModel.fromJson(Map<String, dynamic> json) {
    return CustomerProfileListModel(
      id: json['ID'],
      matriId: json['MatriID'],
      name: json['Name'],
      age: json['Age'],
      address: json['Address'],
      occupation: json['Occupation'],
      educationDetails: json['EducationDetails'],
      moonSign: json['Moonsign'],
      star: json['Star'],
      city: json['City'],
      state: json['State'],
      religion: json['Religion'],
      maritalStatus: json['Maritalstatus'],
      dob: json['DOB'],
      inLaknam: json['InLaknam'],
      caste: json['Caste'],
      image: json['photo1'],
      photoApprove: json['Photo1Approve'],
      complexion: json['Complexion'],
      height: json['Height'],
      fatherName: json['Fathername'],
      fatherOccupation: json['Fathersoccupation'],
      motherName: json['Mothersname'],
      motherOccupation: json['Mothersoccupation'],
      noOfBrothers: json['noofbrothers'],
      noOfSisters: json['noofsisters'],
      horosApprove: json['HorosApprove'],
      horosCheck: json['Horoscheck'],
      liked: json['liked'] ?? "no",
      isUnlocked: json['is_unlocked'] ?? "false",
      verified: json['verified'] ?? "no",
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
    };
  }
}
