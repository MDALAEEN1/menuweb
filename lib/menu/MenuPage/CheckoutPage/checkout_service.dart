import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:menuweb/menu/MenuPage/cartpage/cart_service.dart';

class CheckoutService {
  static Future<Map<String, dynamic>> placeOrder({
    required String fulfillmentMethod,
    required String name,
    required String phone,
    required String address,
    required String notes,
    required String promoCode,
  }) async {
    final items = CartService.getItems();
    if (items.isEmpty) throw "no_items";

    final uid = Hive.box("menu_cache").get("uid");
    if (uid == null) throw "uid_not_found";

    // ID
    final orderId = DateTime.now().millisecondsSinceEpoch.toString();
    final orderNumber = "ORD${orderId.substring(orderId.length - 6)}";

    // حساب الأسعار
    final subtotal = CartService.subtotal();
    final shipping = fulfillmentMethod == "delivery" ? 5.0 : 0.0;
    final tax = subtotal * 0.10;
    final total = subtotal + shipping + tax;

    // بيانات الطلب
    final orderData = {
      "id": orderId,
      "orderNumber": orderNumber,
      "source": "web",
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
      "status": "pending",
      "fulfillmentMethod": fulfillmentMethod,

      "customer": {
        "name": name.trim(),
        "phone": phone.trim(),
        "address": address.trim(),
        "notes": notes.trim(),
        "promoCode": promoCode.trim(),
      },

      "cashier": {"name": "", "uid": ""},

      "items": items.map((item) {
        return {
          "id": item["id"] ?? "",
          "name": item["name"],
          "description": item["description"] ?? "",
          "price": item["price"],
          "qty": item["qty"],
          "image": item["image"] ?? "",
          "color": item["color"] ?? "",
          "size": item["size"] ?? "",
        };
      }).toList(),

      "subtotal": subtotal,
      "shipping": shipping,
      "tax": tax,
      "total": total,
    };

    final firestore = FirebaseFirestore.instance;

    // حفظ الطلب
    await firestore
        .collection("users")
        .doc(uid)
        .collection("orders")
        .doc(orderId)
        .set(orderData);

    // تحديث/إنشاء العميل
    await _updateCustomerProfile(
      uid: uid,
      name: name.trim(),
      phone: phone.trim(),
      address: address.trim(),
      total: total,
      items: items,
      fulfillmentMethod: fulfillmentMethod,
    );

    CartService.clear();

    return {"orderNumber": orderNumber, "orderId": orderId};
  }

  // =================================================================
  // تحديث أو إنشاء ملف العميل بطريقة ذكية
  // =================================================================
  static Future<void> _updateCustomerProfile({
    required String uid,
    required String name,
    required String phone,
    required String address,
    required double total,
    required List items,
    required String fulfillmentMethod,
  }) async {
    final firestore = FirebaseFirestore.instance;

    // البحث عن عميل بنفس رقم الهاتف
    final query = await firestore
        .collection("users")
        .doc(uid)
        .collection("customers")
        .where("phone", isEqualTo: phone)
        .limit(1)
        .get();

    // استخراج المنتجات التي اشتراها لهذا الطلب
    final purchasedIds = items.map<String>((i) => i["id"].toString()).toList();

    // لو العميل موجود
    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      final data = doc.data();

      final previousCount = data["ordersCount"] ?? 0;
      final previousSpent = data["totalSpent"] ?? 0.0;
      final lastOrderAt = data["lastOrderAt"] as Timestamp?;

      // حساب متوسط قيمة الطلب
      final newOrdersCount = previousCount + 1;
      final newTotalSpent = previousSpent + total;
      final newAvgOrderValue = newTotalSpent / newOrdersCount;

      // حساب المدة بين الطلبات
      double avgDaysBetweenOrders = data["avgDaysBetweenOrders"] ?? 0.0;
      if (lastOrderAt != null) {
        final lastDate = lastOrderAt.toDate();
        final diffDays = DateTime.now().difference(lastDate).inDays;
        avgDaysBetweenOrders =
            ((avgDaysBetweenOrders * previousCount) + diffDays) /
            newOrdersCount;
      }

      // recentPurchases: تحديث آخر 10 مشتريات
      List recent = List.from(data["recentPurchases"] ?? []);
      recent.insertAll(0, purchasedIds);
      if (recent.length > 10) recent = recent.sublist(0, 10);

      await doc.reference.update({
        "ordersCount": newOrdersCount,
        "totalSpent": newTotalSpent,
        "avgOrderValue": newAvgOrderValue,
        "avgDaysBetweenOrders": avgDaysBetweenOrders,
        "preferredMethod": fulfillmentMethod,
        "recentPurchases": recent,
        "lastOrderAt": FieldValue.serverTimestamp(),
      });

      return;
    }

    // لو العميل غير موجود – إنشاء ملف جديد
    final newCustomerId = firestore.collection("x").doc().id;

    await firestore
        .collection("users")
        .doc(uid)
        .collection("customers")
        .doc(newCustomerId)
        .set({
          "id": newCustomerId,
          "name": name,
          "phone": phone,
          "address": address,
          "ordersCount": 1,
          "totalSpent": total,
          "avgOrderValue": total,
          "avgDaysBetweenOrders": 0.0,
          "preferredMethod": fulfillmentMethod,
          "recentPurchases": purchasedIds,
          "createdAt": FieldValue.serverTimestamp(),
          "updatedAt": FieldValue.serverTimestamp(),

          "firstOrderAt": FieldValue.serverTimestamp(),
          "lastOrderAt": FieldValue.serverTimestamp(),
          "notes": [],
        });
  }
}
