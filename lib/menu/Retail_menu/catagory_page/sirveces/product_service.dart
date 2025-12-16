import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Box cacheBox = Hive.box("menu_cache");

  // 🔥 جلب المنتجات بفلترة + pagination + category
  Future<Map<String, dynamic>> getProducts({
    required String category,
    int limit = 20,
    DocumentSnapshot? startAfter,
    double? minPrice,
    double? maxPrice,
    String? brand,
    String? color,
  }) async {
    final storeId = cacheBox.get("storeId");
    if (storeId == null) {
      throw Exception("storeId missing in cache");
    }

    Query query = _db
        .collection("users")
        .doc(storeId)
        .collection("products")
        .where("category", isEqualTo: category);

    // -------------- FILTERS --------------
    if (minPrice != null) {
      query = query.where("price", isGreaterThanOrEqualTo: minPrice);
    }
    if (maxPrice != null) {
      query = query.where("price", isLessThanOrEqualTo: maxPrice);
    }
    if (brand != null && brand.isNotEmpty) {
      query = query.where("brand", isEqualTo: brand);
    }
    if (color != null && color.isNotEmpty) {
      query = query.where("color", isEqualTo: color);
    }

    // ---------- PAGINATION ----------
    query = query.limit(limit);
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snap = await query.get();

    final List<Map<String, dynamic>> products = snap.docs.map((d) {
      final data = d.data() as Map<String, dynamic>? ?? {};

      return {"id": d.id, ...data};
    }).toList();

    return {
      "items": products,
      "lastDoc": snap.docs.isNotEmpty ? snap.docs.last : null,
    };
  }
}
