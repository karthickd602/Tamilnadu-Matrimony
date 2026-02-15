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
  final int? heightID;

  /// EDUCATION & WORK
  final String? educationId;
  final String? educationDetails;
  final String? occupationId;
  final String? occupation;
  final String? occupationDetails;
  final int? annualIncome;
  final String? workplace;

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
  final String? childrenLivingStatus;
  final String? nbm;
  final String? nsm;

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
  final String? expections;

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
    this.heightID,
    this.educationId,
    this.educationDetails,
    this.occupationId,
    this.occupation,
    this.occupationDetails,
    this.annualIncome,
    this.workplace,
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
    this.childrenLivingStatus,
    this.nbm,
    this.nsm,
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
    this.expections,
    this.photo1,
    this.photo1Approve,
    this.verified,
    this.speCases,
  });

  factory FetchUserProfileModel.empty() => FetchUserProfileModel(id: 0);

  factory FetchUserProfileModel.fromJson(Map<String, dynamic> json) {
    return FetchUserProfileModel(
      id: json['ID'],
      matriId: json['MatriID'],
      name: json['Name'],
      age: json['Age']?.toString(),
      gender: json['Gender'],
      maritalStatus: json['Maritalstatus'],
      dob: json['DOB'],
      complexion: json['Complexion'],
      height: json['Height'],
      heightID: json['HeightID'],

      educationId: json['Education'],
      educationDetails: json['EducationDetails'],
      occupationId: json['OccupationID'],
      occupation: json['Occupation'],
      occupationDetails: json['Occupationdetails'],
      annualIncome: json['Annualincome'],
      workplace: json['workplace'],

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
      childrenLivingStatus: json['childrenlivingstatus'],
      nbm: json['nbm'],
      nsm: json['nsm'],

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
      expections: json['expections'],


      photo1: json['photo1'],
      photo1Approve: json['Photo1Approve'],

      verified: json['verified'],
      speCases: json['spe_cases'],
    );
  }

}
