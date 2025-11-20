import '../../../utils/constants/path_provider.dart';

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
  final String? maritalStatus;
  final String? caste;
  final String? image;
  final String? photoApprove;
  RxString liked = "no".obs;
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
    this.maritalStatus,
    this.caste,
    this.image,
    this.photoApprove,
    String? liked,
    this.verified,
  }) {
    this.liked.value = liked ?? "no";
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
      maritalStatus: json['Maritalstatus'],
      caste: json['Caste'],
      image: json['photo1'],
      photoApprove: json['Photo1Approve'],
      liked: json['liked'] ?? "no",
      verified: json['verified'] ?? "false",
    );
  }
}
