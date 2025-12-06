import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:menuweb/Retail_menu/Retail_menu.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MenuServicePage extends StatefulWidget {
  const MenuServicePage({super.key});

  @override
  State<MenuServicePage> createState() => _MenuServicePageState();
}

class _MenuServicePageState extends State<MenuServicePage> {
  String? uid;
  String designKey = "default";
  String storeName = "";
  String storetype = "";
  bool loading = true;
  bool error = false;

  final Box cacheBox = Hive.box("menu_cache");

  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> offers = [];
  Map<String, dynamic> socialLinks = {};

  @override
  void initState() {
    super.initState();
    _extractFromUrl();
  }

  // ---------------------------------------------------------------------------
  // Extract UID and designKey from URL
  // ---------------------------------------------------------------------------
  Future<void> _extractFromUrl() async {
    try {
      final uri = Uri.base;
      final segments = uri.pathSegments;

      if (segments.length >= 3 && segments[0] == "menu" && segments[1] == "u") {
        uid = segments[2];
        cacheBox.put("uid", uid);
      } else {
        error = true;
      }

      if (uri.queryParameters.containsKey("designKey")) {
        designKey = uri.queryParameters["designKey"]!;
      }
    } catch (_) {
      error = true;
    }

    if (uid == null) {
      setState(() {
        error = true;
      });
      return;
    }

    try {
      await Future.wait([
        _loadStoreInfo(), // 👈 تمت إضافتها
        _loadProducts(),
        _loadOffers(),
      ]);

      _applyOffers();
    } catch (_) {
      error = true;
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  // ---------------------------------------------------------------------------
  // Load Products From Firestore
  // ---------------------------------------------------------------------------
  Future<void> _loadProducts() async {
    final snap = await FirebaseFirestore.instance
        .collection("publicMenus")
        .doc(uid)
        .collection("items")
        .get();

    products = snap.docs.map((doc) {
      final d = doc.data();

      return {
        "id": doc.id,
        "name": d["name"] ?? "",
        "description": d["description"] ?? "",
        "price": (d["sellingPrice"] ?? d["price"] ?? 0).toDouble(),
        "image": d["image"] ?? "",
        "category": d["category"] ?? "",
        "isAvailable": d["isAvailable"] ?? true,

        // Addons
        "addons": d["addons"] != null
            ? List<Map<String, dynamic>>.from(
                d["addons"].map((e) => Map<String, dynamic>.from(e)),
              )
            : [],

        // Choices
        "choices": d["choiceGroups"] != null
            ? List<Map<String, dynamic>>.from(
                d["choiceGroups"].map(
                  (g) => {
                    "groupName": g["groupName"],
                    "allowMultiple": g["allowMultiple"] ?? false,
                    "items": List<Map<String, dynamic>>.from(
                      g["items"].map((i) => Map<String, dynamic>.from(i)),
                    ),
                  },
                ),
              )
            : [],
      };
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // Load Offers
  // ---------------------------------------------------------------------------
  Future<void> _loadOffers() async {
    try {
      if (uid == null) return;

      final snap = await FirebaseFirestore.instance
          .collection("publicMenus")
          .doc(uid)
          .collection("offers")
          .where(
            "status",
            isEqualTo: "active",
          ) // استخدم English عشان Public API
          .get();

      if (snap.docs.isEmpty) {
        offers = [];
        return;
      }

      offers = snap.docs.map((doc) {
        final d = doc.data();

        return {
          "id": doc.id,
          "type": d["type"] ?? "percent", // percent or fixed
          "discountValue": (d["discountValue"] ?? 0).toDouble(),
          "products": d["products"] != null
              ? List<String>.from(d["products"])
              : <String>[],
        };
      }).toList();
    } catch (e) {
      print("❌ Error loading public offers: $e");
      offers = [];
    }
  }

  // ---------------------------------------------------------------------------
  // Apply Offers to Products
  // ---------------------------------------------------------------------------
  void _applyOffers() {
    for (var product in products) {
      final productId = product["id"];
      final original = product["price"];

      final active = offers.where(
        (offer) => offer["products"].contains(productId),
      );

      if (active.isEmpty) {
        product["hasOffer"] = false;
        continue;
      }

      double lowestPrice = original;
      Map<String, dynamic>? best;

      for (var offer in active) {
        double newPrice = original;

        if (offer["type"] == "percent") {
          newPrice = original * (1 - offer["discountValue"] / 100);
        } else if (offer["type"] == "fixed") {
          newPrice = original - offer["discountValue"];
        }

        if (newPrice < lowestPrice) {
          lowestPrice = newPrice;
          best = offer;
        }
      }

      if (best != null) {
        product["hasOffer"] = true;
        product["offerPrice"] = lowestPrice;
        product["offerType"] = best["type"];
        product["offerValue"] = best["discountValue"];
      }
    }
  }

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    if (error) {
      return const Scaffold(
        body: Center(child: Text("خطأ في الرابط أو البيانات")),
      );
    }

    if (loading) {
      return Skeletonizer(
        enabled: true,
        child: /*DefaultUIPage(
          designKey: designKey,
          products: List.generate(
            8,
            (_) => {
              "name": "Loading...",
              "description": "Loading...",
              "price": 0,
              "image": "",
            },
          ),
        ),*/ StoreHomePage(
          products: List.generate(
            8,
            (_) => {
              "name": "Loading...",
              "description": "Loading...",
              "price": 0,
              "image": "",
            },
          ),
          offers: [],
        ),
      );
    }

    return StoreHomePage(products: products, offers: offers);
    //DefaultUIPage(designKey: designKey, products: products);
  }

  Future<void> _loadStoreInfo() async {
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("publicMenus")
        .doc(uid)
        .get();

    if (doc.exists) {
      final data = doc.data() ?? {};

      // Store Name
      storeName = data["name"] ?? "";
      storetype = data["type"] ?? "";

      // Store Image / Logo
      final storeImage = data["image"] ?? "";

      // Social Links Map
      socialLinks = Map<String, dynamic>.from(data["social"] ?? {});

      // Cache name
      cacheBox.put("storeName_$uid", storeName);
      cacheBox.put("storetype_$uid", storetype);

      // Cache image
      cacheBox.put("storeImage_$uid", storeImage);

      // Cache social links
      cacheBox.put("social_$uid", socialLinks);
    }
  }
}
