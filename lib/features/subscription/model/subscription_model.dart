import 'package:get/get.dart';

class SubscriptionResponse {
  final String? offerName;
  final String? offerImg;
  final List<SubscriptionPlan>? data;

  SubscriptionResponse({
    this.offerName,
    this.offerImg,
    this.data,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponse(
      offerName: json["offer_name"],
      offerImg: json["offer_img"],
      data: json["data"] == null
          ? []
          : List<SubscriptionPlan>.from(
          json["data"].map((x) => SubscriptionPlan.fromJson(x))),
    );
  }
}

class SubscriptionPlan {
  final int planId;
  final String name; // plandisplayname
  final String unlocks; // plannoofcontacts
  final String duration; // planduration
  final String price; // planamount
  final String offerDescription; // planoffers

  /// These are optional extra fields used only for UI
  final int originalPrice;

  SubscriptionPlan({
    required this.planId,
    required this.name,
    required this.unlocks,
    required this.duration,
    required this.price,
    required this.offerDescription,
    this.originalPrice = 0,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      planId: json["planid"],
      name: json["plandisplayname"] ?? "",
      unlocks: json["plannoofcontacts"] ?? "",
      duration: json["planduration"] ?? "",
      price: json["planamount"] ?? "",
      offerDescription: json["planoffers"] ?? "",
      originalPrice:
      int.tryParse(json["planamount"].toString()) != null
          ? (int.parse(json["planamount"].toString()) + 500)
          : 0,
    );
  }
}
