class FetchUserProfileModel {
  /// BASIC
  final int? id;
  final String? matriId;
  final String? name;
  final String? age;
  final String? gender;
  final String? maritalStatus;
  final String? dob;
  final String? complexion;
  final String? height;

  /// EDUCATION & WORK
  final String? educationId;
  final String? educationDetails;
  final String? occupationId;
  final String? occupation;

  /// RELIGION
  final String? religionId;
  final String? religion;
  final String? casteId;
  final String? caste;
  final String? subCaste;
  final String? noCaste;

  /// FAMILY
  final String? fatherName;
  final String? fathersOccupation;
  final String? motherName;
  final String? mothersOccupation;
  final String? familyStatus;
  final String? noOfBrothers;
  final String? noOfSisters;
  final String? irupidam;

  /// LOCATION
  final String? countryId;
  final String? country;
  final String? stateId;
  final String? state;
  final String? cityId;
  final String? city;
  final String? address;
  final String? postal;

  /// CONTACT
  final String? phone;
  final String? mobile;
  final String? confirmEmail;

  /// HOROSCOPE
  final String? moonsign;
  final String? star;
  final String? dasaType;
  final String? thosam;
  final String? thoosamType;
  final String? inLaknam;
  final String? horosApprove;
  final String? horosCheck;

  /// IMAGES
  final String? photo1;
  final String? photo1Approve;

  /// STATUS
  final String? verified;
  final String? speCases;

  FetchUserProfileModel({
    this.id,
    this.matriId,
    this.name,
    this.age,
    this.gender,
    this.maritalStatus,
    this.dob,
    this.complexion,
    this.height,
    this.educationId,
    this.educationDetails,
    this.occupationId,
    this.occupation,
    this.religionId,
    this.religion,
    this.casteId,
    this.caste,
    this.subCaste,
    this.noCaste,
    this.fatherName,
    this.fathersOccupation,
    this.motherName,
    this.mothersOccupation,
    this.familyStatus,
    this.noOfBrothers,
    this.noOfSisters,
    this.irupidam,
    this.countryId,
    this.country,
    this.stateId,
    this.state,
    this.cityId,
    this.city,
    this.address,
    this.postal,
    this.phone,
    this.mobile,
    this.confirmEmail,
    this.moonsign,
    this.star,
    this.dasaType,
    this.thosam,
    this.thoosamType,
    this.inLaknam,
    this.horosApprove,
    this.horosCheck,
    this.photo1,
    this.photo1Approve,
    this.verified,
    this.speCases,
  });

  /// EMPTY FACTORY (SAFE DEFAULT)
  factory FetchUserProfileModel.empty() => FetchUserProfileModel(id: 0);

  /// JSON → MODEL
  factory FetchUserProfileModel.fromJson(Map<String, dynamic> json) {
    return FetchUserProfileModel(
      id: json['ID'],
      matriId: json['MatriID'],
      name: json['Name'],
      age: json['Age'],
      gender: json['Gender'],
      maritalStatus: json['Maritalstatus'],
      dob: json['DOB'],
      complexion: json['Complexion'],
      height: json['Height'],

      educationId: json['Education'],
      educationDetails: json['EducationDetails'],
      occupationId: json['OccupationID'],
      occupation: json['Occupation'],

      religionId: json['ReligionID'],
      religion: json['Religion'],
      casteId: json['CasteID'],
      caste: json['Caste'],
      subCaste: json['Subcaste'],
      noCaste: json['nocaste'],

      fatherName: json['Fathername'],
      fathersOccupation: json['Fathersoccupation'],
      motherName: json['Mothersname'],
      mothersOccupation: json['Mothersoccupation'],
      familyStatus: json['FamilyStatus'],
      noOfBrothers: json['noofbrothers'],
      noOfSisters: json['noofsisters'],
      irupidam: json['irupidam'],

      countryId: json['CountryID'],
      country: json['Country'],
      stateId: json['StateID'],
      state: json['State'],
      cityId: json['CityID'],
      city: json['City'],
      address: json['Address'],
      postal: json['Postal'],

      phone: json['Phone'],
      mobile: json['Mobile'],
      confirmEmail: json['ConfirmEmail'],

      moonsign: json['Moonsign'],
      star: json['Star'],
      dasaType: json['dasatype'],
      thosam: json['thosam'],
      thoosamType: json['thoosamtype'],
      inLaknam: json['InLaknam'],
      horosApprove: json['HorosApprove'],
      horosCheck: json['Horoscheck'],

      photo1: json['photo1'],
      photo1Approve: json['Photo1Approve'],

      verified: json['verified'],
      speCases: json['spe_cases'],
    );
  }

  /// MODEL → JSON (for update)
  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "Name": name,
      "Gender": gender,
      "DOB": dob,
      "Maritalstatus": maritalStatus,
      "Complexion": complexion,
      "Height": height,
      "Education": educationId,
      "EducationDetails": educationDetails,
      "Occupation": occupationId,
      "Religion": religionId,
      "Caste": casteId,
      "Subcaste": subCaste,
      "CountryID": countryId,
      "StateID": stateId,
      "CityID": cityId,
      "Address": address,
      "Postal": postal,
      "Phone": phone,
      "ConfirmEmail": confirmEmail,
      "Moonsign": moonsign,
      "Star": star,
      "dasatype": dasaType,
      "thosam": thosam,
      "thoosamtype": thoosamType,
      "InLaknam": inLaknam,
      "spe_cases": speCases,
    };
  }
}
