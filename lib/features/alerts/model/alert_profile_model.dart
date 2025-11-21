class AlertProfileModel {
  final int id;
  final String matriId;
  final String name;
  final String age;
  final String height;
  final String occupation;
  final String educationDetails;
  final String city;
  final String caste;
  final String photo1;
  final String photo1Approve;
  final String eisentdt;

  AlertProfileModel({
    required this.id,
    required this.matriId,
    required this.name,
    required this.age,
    required this.height,
    required this.occupation,
    required this.educationDetails,
    required this.city,
    required this.caste,
    required this.photo1,
    required this.photo1Approve,
    required this.eisentdt,
  });

  factory AlertProfileModel.fromJson(Map<String, dynamic> json) {
    return AlertProfileModel(
      id: json['ID'] ?? 0,
      matriId: json['MatriID'] ?? '',
      name: json['Name'] ?? '',
      age: json['Age'] ?? '',
      height: json['Height'] ?? '',
      occupation: json['Occupation'] ?? '',
      educationDetails: json['EducationDetails'] ?? '',
      city: json['City'] ?? '',
      caste: json['Caste'] ?? '',
      photo1: json['photo1'] ?? '',
      photo1Approve: json['Photo1Approve'] ?? '',
      eisentdt: json['eisentdt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'MatriID': matriId,
    'Name': name,
    'Age': age,
    'Height': height,
    'Occupation': occupation,
    'EducationDetails': educationDetails,
    'City': city,
    'Caste': caste,
    'photo1': photo1,
    'Photo1Approve': photo1Approve,
    'eisentdt': eisentdt,
  };
}
