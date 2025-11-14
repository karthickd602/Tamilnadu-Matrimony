class ProfilesResponse {
  final String? message;
  final int? statusCode;
  final int? currentPage;
  final int? total;
  final List<dynamic>? filtersUsed;
  final List<CustomerProfileListModel>? profiles;

  ProfilesResponse({
    this.message,
    this.statusCode,
    this.currentPage,
    this.total,
    this.filtersUsed,
    this.profiles,
  });

  factory ProfilesResponse.fromJson(Map<String, dynamic> json) {
    return ProfilesResponse(
      message: json['message'],
      statusCode: json['statusCode'],
      currentPage: json['current_page'],
      total: json['total'],
      filtersUsed: json['filters_used'],
      profiles: json['profiles'] != null
          ? List<CustomerProfileListModel>.from(
          json['profiles'].map((x) => CustomerProfileListModel.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "statusCode": statusCode,
    "current_page": currentPage,
    "total": total,
    "filters_used": filtersUsed,
    "profiles": profiles?.map((x) => x.toJson()).toList(),
  };
}
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
  });

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
    );
  }

  Map<String, dynamic> toJson() => {
    "ID": id,
    "MatriID": matriId,
    "Name": name,
    "Age": age,
    "Address": address,
    "Occupation": occupation,
    "EducationDetails": educationDetails,
    "Moonsign": moonSign,
    "Star": star,
    "City": city,
    "Maritalstatus": maritalStatus,
    "Caste": caste,
  };
}
