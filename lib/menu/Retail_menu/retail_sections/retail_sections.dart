class RetailSections {
  final List<Map<String, dynamic>> products;

  RetailSections({required this.products});

  // ---------------------------------------------------------------------------
  // NEW ARRIVALS — أول 8 منتجات
  // ---------------------------------------------------------------------------
  List<Map<String, dynamic>> getNewArrivals() {
    return products.take(8).toList();
  }

  // ---------------------------------------------------------------------------
  // CATEGORIES — جمع الكاتيجوري من المنتجات
  // ---------------------------------------------------------------------------
  List<Map<String, dynamic>> getCategories() {
    final Map<String, String> categoryImages = {};

    for (var p in products) {
      final cat = p["category"] ?? "";
      if (cat.isEmpty) continue;

      if (!categoryImages.containsKey(cat)) {
        categoryImages[cat] = p["image"];
      }
    }

    return categoryImages.entries.map((e) {
      return {"name": e.key, "image": e.value};
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // BEST SELLERS — من المنتجات التي تحتوي isBestSeller = true
  // ---------------------------------------------------------------------------
  List<Map<String, dynamic>> getBestSellers() {
    return products.where((p) {
      return p["isBestSeller"] == true;
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // GET PRODUCTS FOR A SPECIFIC CATEGORY
  // ---------------------------------------------------------------------------
  List<Map<String, dynamic>> getProductsByCategory(String category) {
    return products.where((p) => (p["category"] ?? "") == category).toList();
  }
}
