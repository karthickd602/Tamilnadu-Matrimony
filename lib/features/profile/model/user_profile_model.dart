

class FetchUserProfileModel {
  int? id;
  String? matriId;
  String? name;
  String? age;
  String? address;
  String? occupationId;
  String? occupation;
  String? educationDetails;
  String? moonsign;
  String? star;
  String? cityId;
  String? city;
  String? stateId;
  String? state;
  String? religionId;
  String? religion;
  String? maritalStatus;
  String? dob;
  String? inLaknam;
  String? casteId;
  String? caste;
  String? photo1;
  String? photo1Approve;
  String? complexion;
  String? height;
  String? fatherName;
  String? fathersOccupation;
  String? motherName;
  String? mothersOccupation;
  String? noOfBrothers;
  String? noOfSisters;
  String? horosApprove;
  String? horosCheck;
  String? verified;

  factory FetchUserProfileModel.empty() {
    return FetchUserProfileModel(
      id: 0,
      matriId: "",
      name: "",
      age: "",
      address: "",
      occupationId: "",
      occupation: "",
      educationDetails: "",
      moonsign: "",
      star: "",
      cityId: "",
      city: "",
      stateId: "",
      state: "",
      religionId: "",
      religion: "",
      maritalStatus: "",
      dob: "",
      inLaknam: "",
      casteId: "",
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
      horosApprove: "",
      horosCheck: "",
      verified: "",
    );
  }

  FetchUserProfileModel({
    this.id,
    this.matriId,
    this.name,
    this.age,
    this.address,
    this.occupationId,
    this.occupation,
    this.educationDetails,
    this.moonsign,
    this.star,
    this.cityId,
    this.city,
    this.stateId,
    this.state,
    this.religionId,
    this.religion,
    this.maritalStatus,
    this.dob,
    this.inLaknam,
    this.casteId,
    this.caste,
    this.photo1,
    this.photo1Approve,
    this.complexion,
    this.height,
    this.fatherName,
    this.fathersOccupation,
    this.motherName,
    this.mothersOccupation,
    this.noOfBrothers,
    this.noOfSisters,
    this.horosApprove,
    this.horosCheck,
    this.verified,
  });

  factory FetchUserProfileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return FetchUserProfileModel();

    return FetchUserProfileModel(
      id: json['ID'],
      matriId: json['MatriID'],
      name: json['Name'],
      age: json['Age'],
      address: json['Address'],
      occupationId: json['OccupationID'],
      occupation: json['Occupation'],
      educationDetails: json['EducationDetails'],
      moonsign: json['Moonsign'],
      star: json['Star'],
      cityId: json['CityID'],
      city: json['City'],
      stateId: json['StateID'],
      state: json['State'],
      religionId: json['ReligionID'],
      religion: json['Religion'],
      maritalStatus: json['Maritalstatus'],
      dob: json['DOB'],
      inLaknam: json['InLaknam'],
      casteId: json['CasteID'],
      caste: json['Caste'],
      photo1: json['photo1'],
      photo1Approve: json['Photo1Approve'],
      complexion: json['Complexion'],
      height: json['Height'],
      fatherName: json['Fathername'],
      fathersOccupation: json['Fathersoccupation'],
      motherName: json['Mothersname'],
      mothersOccupation: json['Mothersoccupation'],
      noOfBrothers: json['noofbrothers'],
      noOfSisters: json['noofsisters'],
      horosApprove: json['HorosApprove'],
      horosCheck: json['Horoscheck'],
      verified: json['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'MatriID': matriId,
      'Name': name,
      'Age': age,
      'Address': address,
      'OccupationID': occupationId,
      'Occupation': occupation,
      'EducationDetails': educationDetails,
      'Moonsign': moonsign,
      'Star': star,
      'CityID': cityId,
      'City': city,
      'StateID': stateId,
      'State': state,
      'ReligionID': religionId,
      'Religion': religion,
      'Maritalstatus': maritalStatus,
      'DOB': dob,
      'InLaknam': inLaknam,
      'CasteID': casteId,
      'Caste': caste,
      'photo1': photo1,
      'Photo1Approve': photo1Approve,
      'Complexion': complexion,
      'Height': height,
      'Fathername': fatherName,
      'Fathersoccupation': fathersOccupation,
      'Mothersname': motherName,
      'Mothersoccupation': mothersOccupation,
      'noofbrothers': noOfBrothers,
      'noofsisters': noOfSisters,
      'HorosApprove': horosApprove,
      'Horoscheck': horosCheck,
      'verified': verified,
    };
  }
}
