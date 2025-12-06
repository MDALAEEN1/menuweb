import 'package:hive_flutter/hive_flutter.dart';

class CartService {
  static final Box cartBox = Hive.box('cart_box');

  // ========= NEW =========
  static String? storeId;

  static void setStore(String id) {
    storeId = id;
  }

  static String _key() {
    return "items_${storeId ?? "default"}";
  }

  // ---------------------------------------------------------
  // Get All Items
  // ---------------------------------------------------------
  static List<Map<String, dynamic>> getItems() {
    final raw = cartBox.get(_key(), defaultValue: []);

    return List<Map<String, dynamic>>.from(
      raw.map((e) => Map<String, dynamic>.from(e as Map)),
    );
  }

  // ---------------------------------------------------------
  // ADD ITEM
  // ---------------------------------------------------------
  static void addItem(Map<String, dynamic> product) {
    List<Map<String, dynamic>> cart = getItems();

    String id = product["id"]; // ← أهم سطر
    String name = product["name"];
    double price = product["price"]?.toDouble() ?? 0;
    String image = product["image"] ?? "";
    int qty = product["qty"] ?? 1;

    String color = product["color"] ?? "";
    String size = product["size"] ?? "";

    // البحث عن العنصر نفسه بنفس ID + الخيارات
    int index = cart.indexWhere(
      (item) =>
          item["id"] == id && // ← لازم يكون ID
          item["color"] == color &&
          item["size"] == size,
    );

    if (index != -1) {
      cart[index]["qty"] += qty;
    } else {
      cart.add({
        "id": id, // ← ID أصبح محفوظ
        "name": name,
        "description": product["description"] ?? "",
        "price": price,
        "image": image,
        "qty": qty,
        "color": color,
        "size": size,
        "addedAt": DateTime.now().millisecondsSinceEpoch,
      });
    }

    cartBox.put(_key(), cart);
  }

  // ---------------------------------------------------------
  // Update Qty
  // ---------------------------------------------------------
  static void updateQty(int index, int qty) {
    List<Map<String, dynamic>> cart = getItems();

    if (qty <= 0) {
      cart.removeAt(index);
    } else {
      cart[index]["qty"] = qty;
    }

    cartBox.put(_key(), cart);
  }

  // ---------------------------------------------------------
  // Delete
  // ---------------------------------------------------------
  static void deleteItem(int index) {
    List<Map<String, dynamic>> cart = getItems();
    cart.removeAt(index);
    cartBox.put(_key(), cart);
  }

  // ---------------------------------------------------------
  // Subtotal
  // ---------------------------------------------------------
  static double subtotal() {
    double sum = 0;
    for (var item in getItems()) {
      sum += (item["price"] * item["qty"]);
    }
    return sum;
  }

  static void clear() {
    cartBox.put(_key(), []);
  }
}
