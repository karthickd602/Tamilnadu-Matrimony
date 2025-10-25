// class OtpResponse {
//   final String message;
//   final int statusCode;
//   final List<LoginOtpModel> data;
//
//   OtpResponse({
//     required this.message,
//     required this.statusCode,
//     required this.data,
//   });
//
//   factory OtpResponse.fromJson(Map<String, dynamic> json) {
//     return OtpResponse(
//       message: json['message'] ?? '',
//       statusCode: json['statusCode'] ?? 0,
//       data: (json['data'] as List<dynamic>?)
//           ?.map((e) => LoginOtpModel.fromJson(e))
//           .toList() ??
//           [],
//     );
//   }
//   Map<String, dynamic> toJson() => {
//     'message': message,
//     'statusCode': statusCode,
//     'data': data.map((e) => e.toJson()).toList(),
//   };
// }

class LoginOtpModel {
  final String mobileNo;
  final String otp;
  final String expiryTime;

  LoginOtpModel({
    required this.mobileNo,
    required this.otp,
    required this.expiryTime,
  });

  factory LoginOtpModel.fromJson(Map<String, dynamic> json) {
    return LoginOtpModel(
      mobileNo: json['mobile_no'] ?? '',
      otp: json['otp'] ?? '',
      expiryTime: json['expiry_time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'mobile_no': mobileNo,
    'otp': otp,
    'expiry_time': expiryTime,
  };
}
