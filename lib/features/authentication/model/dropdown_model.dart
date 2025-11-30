

class OccupationDDModel {
  final int? id;
  final String? name;
  final int? sortOrder;
  final String? status;

  OccupationDDModel({
    this.id,
    this.name,
    this.sortOrder,
    this.status,
  });

  factory OccupationDDModel.fromJson(Map<String, dynamic> json) {
    return OccupationDDModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      sortOrder: json['sortorder'] as int?,
      status: json['status'] as String?,
    );
  }

}


class EducationDDModel {
  final int? id;
  final String? name;
  final int? sortOrder;
  final String? status;

  EducationDDModel({
    this.id,
    this.name,
    this.sortOrder,
    this.status,
  });

  factory EducationDDModel.fromJson(Map<String, dynamic> json) {
    return EducationDDModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      sortOrder: json['sortorder'] as int?,
      status: json['status'] as String?,
    );
  }

}

class ReligionDDModel {
  final int id;
  final String? name;
  final String? sortOrder;
  final String? status;

  ReligionDDModel({
   required this.id,
    this.name,
    this.sortOrder,
    this.status,
  });

  factory ReligionDDModel.fromJson(Map<String, dynamic> json) {
    return ReligionDDModel(
      id: json['id'] as int,
      name: json['name'] as String?,
      sortOrder: json['sortorder'] as String?,
      status: json['status'] as String?,
    );
  }

}


class CasteDDModel {
  final int? id;
  final String? name;
  final int? religion;
  final int? sortOrder;
  final String? status;

  CasteDDModel({
    this.id,
    this.name,
    this.sortOrder,
    this.religion,
    this.status,
  });

  factory CasteDDModel.fromJson(Map<String, dynamic> json) {
    return CasteDDModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      religion: json['religion'] as int?,
      sortOrder: json['sortorder'] as int?,
      status: json['status'] as String?,
    );
  }

}


class CountryModel {
  final int? id;
  final String? name;
  final String? code;
  final int? phoneCode;
  final int? sortOrder;
  final String? status;

  CountryModel({
    this.id,
    this.name,
    this.code,
    this.phoneCode,
    this.sortOrder,
    this.status,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      phoneCode: json['phonecode'],
      sortOrder: json['sortorder'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "code": code,
      "phonecode": phoneCode,
      "sortorder": sortOrder,
      "status": status,
    };
  }
}