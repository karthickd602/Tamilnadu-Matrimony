  class CustomerUserModel {
  int id;
  String matriId;
  String name;
  String age;
  String address;
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
  String horosApprove;
  String horosCheck;
  String liked;
  String verified;

  /// Default constructor
  CustomerUserModel({
    required this.id,
    required this.matriId,
    required this.name,
    required this.age,
    required this.address,
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
    required this.horosApprove,
    required this.horosCheck,
    required this.liked,
    required this.verified,
  });

  /// 🔥 Empty Default Model
  factory CustomerUserModel.empty() {
    return CustomerUserModel(
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
      liked: "",
      verified: "",
    );
  }

  /// 🔄 Convert JSON → Model
  factory CustomerUserModel.fromJson(Map<String, dynamic> json) {
    return CustomerUserModel(
      id: json["ID"] ?? 0,
      matriId: json["MatriID"] ?? "",
      name: json["Name"] ?? "",
      age: json["Age"] ?? "",
      address: json["Address"] ?? "",
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
      horosApprove: json["HorosApprove"] ?? "",
      horosCheck: json["Horoscheck"]?.toString() ?? "",
      liked: json["liked"] ?? "",
      verified: json["verified"] ?? "",
    );
  }

  /// 🔁 Convert Model → JSON
  Map<String, dynamic> toJson() {
    return {
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
      "State": state,
      "Religion": religion,
      "Maritalstatus": maritalStatus,
      "DOB": dob,
      "InLaknam": inLaknam,
      "Caste": caste,
      "photo1": photo1,
      "Photo1Approve": photo1Approve,
      "Complexion": complexion,
      "Height": height,
      "Fathername": fatherName,
      "Fathersoccupation": fathersOccupation,
      "Mothersname": motherName,
      "Mothersoccupation": mothersOccupation,
      "noofbrothers": noOfBrothers,
      "noofsisters": noOfSisters,
      "HorosApprove": horosApprove,
      "Horoscheck": horosCheck,
      "liked": liked,
      "verified": verified,
    };
  }
}
