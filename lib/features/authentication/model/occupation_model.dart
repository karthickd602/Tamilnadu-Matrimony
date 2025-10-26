import 'dart:convert';

class OccupationResponse {
  final String? message;
  final int? statusCode;
  final List<OccupationDDModel>? data;

  OccupationResponse({
    this.message,
    this.statusCode,
    this.data,
  });

  factory OccupationResponse.fromJson(Map<String, dynamic> json) {
    return OccupationResponse(
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OccupationDDModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'statusCode': statusCode,
    'data': data?.map((e) => e.toJson()).toList(),
  };

  /// Helper to parse from raw JSON string
  static OccupationResponse fromRawJson(String str) =>
      OccupationResponse.fromJson(json.decode(str));

  /// Helper to convert to raw JSON string
  String toRawJson() => json.encode(toJson());
}

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

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'sortorder': sortOrder,
    'status': status,
  };
}
