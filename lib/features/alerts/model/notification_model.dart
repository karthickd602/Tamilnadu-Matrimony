class NotificationResponse {
  final String message;
  final int statusCode;
  final String anLogo;
  final List<NotificationModel> data;

  NotificationResponse({
    required this.message,
    required this.statusCode,
    required this.anLogo,
    required this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      anLogo: json['an_logo'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NotificationModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class NotificationModel {
  final int id;
  final String title;
  final String description;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      title: json['an_title'] ?? '',
      description: json['an_name'] ?? '',
      createdAt: json['an_created_at'] ?? '',
    );
  }
}
