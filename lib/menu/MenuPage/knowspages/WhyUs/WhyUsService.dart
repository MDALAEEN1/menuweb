import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class WhyUsService {
  final Box cacheBox = Hive.box("menu_cache");

  String? uid;
  String? storeId;

  WhyUsService() {
    uid = cacheBox.get("uid");
    storeId = cacheBox.get("storeId"); // من الكاش مباشرة إذا موجود
  }

  Future<Map<String, dynamic>> loadWhyUsData() async {
    // تحميل uid إن لم يكن بالكاش
    uid ??= cacheBox.get("uid");
    if (uid == null) return {};

    // تحميل storeId إذا لم يكن متوفراً
    storeId ??= cacheBox.get("storeId");
    if (storeId == null) {
      final stores = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("myStores")
          .limit(1)
          .get();

      if (stores.docs.isEmpty) return {};
      storeId = stores.docs.first.id;
      cacheBox.put("storeId", storeId);
    }

    // قراءة نفس وثيقة المتجر
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("myStores")
        .doc(storeId)
        .get();

    if (!doc.exists) return {};

    final data = doc.data() ?? {};

    // تحويل البيانات لصيغة تقرأها الواجهة
    return {
      // HEADER (اسم المتجر والخلفية)
      "headerTitle": data["storeName"] ?? "",
      "headerSubtitle": data["businessType"] ?? "",
      "headerImage": data["imageUrl"] ?? "",

      // STORY
      "storyTitle": "Our Story",
      "storyBody": data["ourStory"] ?? "",

      // CONTACT
      "address": data["address"] ?? "",
      "phone": data["phone"] ?? "",
      "email": data["email"] ?? "",

      // HOURS → تحويل workingHours Map إلى List
      "hours": _convertHours(data["workingHours"]),

      // SOCIAL
      "facebook": data["facebookLink"] ?? "",
      "instagram": data["instagramLink"] ?? "",
      "whatsapp": data["whatsappLink"] ?? "",
      "tiktok": data["tiktokLink"] ?? "",
      "website": data["websiteLink"] ?? "",
    };
  }

  List<Map<String, String>> _convertHours(dynamic workingHours) {
    if (workingHours is! Map) return [];

    final List<Map<String, String>> result = [];

    final days = {
      "mon": "Monday",
      "tue": "Tuesday",
      "wed": "Wednesday",
      "thu": "Thursday",
      "fri": "Friday",
      "sat": "Saturday",
      "sun": "Sunday",
    };

    workingHours.forEach((key, value) {
      if (value["enabled"] == true) {
        result.add({
          "day": days[key] ?? key,
          "time": "${value["open"]} - ${value["close"]}",
        });
      }
    });

    return result;
  }
}
