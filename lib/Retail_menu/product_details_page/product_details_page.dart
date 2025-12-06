import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/MenuPage/customWebAppBar/customWebAppBar.dart';

import 'package:menuweb/MenuPage/product_details_page/product_details_service.dart';
import 'package:menuweb/Retail_menu/footerSection/footersection.dart';
import 'package:menuweb/generated/l10n.dart';

class ProductPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final List<Map<String, dynamic>> allProducts;
  const ProductPage({
    super.key,
    required this.product,
    required this.allProducts,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int selectedColor = 0;
  int quantity = 1;

  int expandedPanel = 0; // 0: description, 1: specs, 2: shipping

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 700;
    final bool isTablet = width >= 700 && width < 1100;
    final bool isDesktop = width >= 1100;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: customWebAppBar(context),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // ============================
                  // المحتوى يتمدّد لملء الشاشة
                  // ============================
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16 : 24,
                            vertical: isMobile ? 16 : 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24),

                              // -------------------------------
                              // بيانات المنتج
                              // -------------------------------
                              if (isDesktop || isTablet)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: _ProductImages(
                                        product: widget.product,
                                      ),
                                    ),
                                    const SizedBox(width: 32),
                                    Expanded(
                                      flex: 5,
                                      child: _ProductInfo(
                                        product: widget.product,
                                        quantity: quantity,
                                        onChangeQuantity: (q) =>
                                            setState(() => quantity = q),
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Column(
                                  children: [
                                    _ProductImages(product: widget.product),
                                    const SizedBox(height: 24),
                                    _ProductInfo(
                                      product: widget.product,
                                      quantity: quantity,
                                      onChangeQuantity: (q) =>
                                          setState(() => quantity = q),
                                    ),
                                  ],
                                ),

                              const SizedBox(height: 32),

                              // -------------------------------
                              // منتجات مشابهة
                              // -------------------------------
                              YouMightAlsoLikeSection(
                                currentProduct: widget.product,
                                allProducts: widget.allProducts,
                              ),

                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ============================
                  // FOOTER
                  // ============================
                  FooterSection(
                    horizontalPadding: isMobile ? 16 : 24,
                    isMobile: isMobile,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// =========================
// Product Images
// =========================

class _ProductImages extends StatelessWidget {
  final Map<String, dynamic> product;

  const _ProductImages({required this.product});

  @override
  Widget build(BuildContext context) {
    final String image = product["image"] ?? "";
    final String title = product["name"] ?? "Product";

    return AspectRatio(
      aspectRatio: 6 / 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: image.isNotEmpty
            ? Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholder(title),
              )
            : _placeholder(title),
      ),
    );
  }

  // ===========================
  // 🟣 Placeholder جميل + يدعم العربية
  // ===========================
  Widget _placeholder(String title) {
    // تحديد هل الاسم عربي
    final bool isArabic = RegExp(r'^[\u0600-\u06FF]').hasMatch(title);

    // استخراج أحرف العرض
    String initials;

    if (title.isEmpty) {
      initials = "?";
    } else if (isArabic) {
      initials = title.substring(0, 1); // حرف واحد يكفي
    } else {
      initials = title.length >= 2
          ? title.substring(0, 2).toUpperCase()
          : title.substring(0, 1).toUpperCase();
    }

    // لون ثابت مبني على hash لاسم المنتج
    final Color bgColor =
        Colors.primaries[title.hashCode % Colors.primaries.length].shade300;

    return Container(
      color: bgColor,
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// =========================
// Product Info (يمين)
// =========================

class _ProductInfo extends StatefulWidget {
  final Map<String, dynamic> product;
  final int quantity;
  final ValueChanged<int> onChangeQuantity;

  const _ProductInfo({
    required this.product,
    required this.quantity,
    required this.onChangeQuantity,
  });

  @override
  State<_ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<_ProductInfo> {
  // ----- اختيار الإضافات (Checkbox) -----
  final Map<String, bool> selectedAddons = {};

  // ----- اختيار الخيارات (Radio Groups) -----
  final Map<String, String> selectedChoices = {};

  // ----- السعر النهائي -----
  double finalPrice = 0.0;

  @override
  void initState() {
    super.initState();

    // تجهيز addons
    for (var addon in widget.product["addons"] ?? []) {
      selectedAddons[addon["name"]] = false;
    }

    // تجهيز choices
    for (var group in widget.product["choices"] ?? []) {
      final groupName = group["groupName"];
      final items = group["items"] as List;

      if (items.isNotEmpty) {
        selectedChoices[groupName] = items.first["name"];
      }
    }

    // السعر الأساسي
    finalPrice = (widget.product["price"] ?? 0).toDouble();
  }

  // -------------------------------------------------
  // 🔥 حساب السعر النهائي كلما تغيّر أي خيار
  // -------------------------------------------------
  void _recalculatePrice() {
    final product = widget.product;

    double base = (product["price"] ?? 0).toDouble();
    double addonsTotal = 0;
    double choicesTotal = 0;

    // ADDONS
    for (var addon in product["addons"] ?? []) {
      if (selectedAddons[addon["name"]] == true) {
        addonsTotal += (addon["extraPrice"] ?? 0).toDouble();
      }
    }

    // CHOICES
    for (var group in product["choices"] ?? []) {
      final groupName = group["groupName"];
      final selectedName = selectedChoices[groupName];

      if (selectedName != null) {
        final items = group["items"] as List;
        final found = items.firstWhere(
          (i) => i["name"] == selectedName,
          orElse: () => <String, dynamic>{},
        );

        if (found != null) {
          choicesTotal += (found["extraPrice"] ?? 0).toDouble();
        }
      }
    }

    // MULTIPLY BY QTY
    double total = (base + addonsTotal + choicesTotal) * widget.quantity;

    setState(() {
      finalPrice = total;
    });

    print("ADDONS: $addonsTotal");
    print("CHOICES: $choicesTotal");
    print("FINAL: $finalPrice");
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================================
        // NAME + DYNAMIC PRICE
        // ================================
        Text(
          p["name"] ?? "Product",
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        Text(
          "${finalPrice.toStringAsFixed(2)} \$",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),

        // ================================
        // DESCRIPTION
        // ================================
        if (p["description"] != null)
          Text(
            p["description"],
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),

        const SizedBox(height: 24),

        // ================================
        // ADDONS SECTION
        // ================================
        if ((p["addons"] ?? []).isNotEmpty) ...[
          Text(
            S.of(context).productAddOns,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          Column(
            children: (p["addons"] as List).map((addon) {
              final name = addon["name"];
              final price = addon["extraPrice"]?.toDouble() ?? 0;

              return CheckboxListTile(
                value: selectedAddons[name],
                onChanged: (v) {
                  setState(() {
                    selectedAddons[name] = v ?? false;
                  });
                  _recalculatePrice();
                },
                title: Text(
                  "$name (+${price.toStringAsFixed(2)}\$)",
                  style: const TextStyle(fontSize: 13),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
        ],

        // ================================
        // CHOICES SECTION
        // ================================
        if ((p["choices"] ?? []).isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (p["choices"] as List).map((group) {
              final groupName = group["groupName"];
              final items = group["items"] as List;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groupName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  ...items.map((item) {
                    final name = item["name"];
                    final price = item["extraPrice"]?.toDouble() ?? 0;

                    return RadioListTile(
                      value: name,
                      groupValue: selectedChoices[groupName],
                      onChanged: (v) {
                        setState(() {
                          selectedChoices[groupName] = v!;
                        });
                        _recalculatePrice();
                      },
                      title: Text(
                        "$name (+${price.toStringAsFixed(2)})",
                        style: const TextStyle(fontSize: 13),
                      ),
                      dense: true,
                    );
                  }).toList(),

                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          ),

        // ================================
        // QUANTITY + ADD TO CART
        // ================================
        Row(
          children: [
            // Quantity Box
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 18),
                    onPressed: widget.quantity > 1
                        ? () {
                            widget.onChangeQuantity(widget.quantity - 1);
                            _recalculatePrice();
                          }
                        : null,
                  ),
                  Text(
                    widget.quantity.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: () {
                      widget.onChangeQuantity(widget.quantity + 1);
                      _recalculatePrice();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // ADD TO CART BUTTON
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // -----------------------------
                  // معالجة ADDONS المختارة
                  // -----------------------------
                  final List<Map<String, dynamic>> addonsList =
                      List<Map<String, dynamic>>.from(
                        widget.product["addons"] ?? [],
                      );

                  final List<Map<String, dynamic>>
                  selectedAddonsList = addonsList
                      .where((addon) => selectedAddons[addon["name"]] == true)
                      .map((addon) {
                        return {
                          "name": addon["name"],
                          "extraPrice": (addon["extraPrice"] ?? 0).toDouble(),
                        };
                      })
                      .toList();

                  // -----------------------------
                  // معالجة الخيارات المختارة
                  // -----------------------------
                  final Map<String, Map<String, dynamic>> selectedChoicesFixed =
                      {};

                  final choicesList =
                      (widget.product["choices"] as List?) ?? [];

                  selectedChoices.forEach((groupName, selectedItemName) {
                    double extraPrice = 0.0;

                    final groupMatches = choicesList.where(
                      (g) => g["groupName"] == groupName,
                    );
                    if (groupMatches.isNotEmpty) {
                      final items =
                          (groupMatches.first["items"] as List?) ?? [];
                      final itemMatches = items.where(
                        (i) => i["name"] == selectedItemName,
                      );
                      if (itemMatches.isNotEmpty) {
                        extraPrice = (itemMatches.first["extraPrice"] ?? 0)
                            .toDouble();
                      }
                    }

                    selectedChoicesFixed[groupName] = {
                      "name": selectedItemName,
                      "extraPrice": extraPrice,
                    };
                  });

                  // -----------------------------
                  // إضافة للسلة
                  // -----------------------------
                  ProductDetailsService.addProductToCart(
                    widget.product,
                    widget.quantity,
                    image: widget.product["image"],
                    addons: selectedAddonsList,
                    choices: selectedChoicesFixed,
                  );

                  // -----------------------------
                  // Snackbar
                  // -----------------------------
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "تم إضافة المنتج: ${widget.product["name"]} إلى السلة",
                      ),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                child: Text(
                  S.of(context).productAddToCart,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// =========================
// Details Accordion
// =========================

class _DetailsAccordion extends StatelessWidget {
  final int expandedPanel;
  final ValueChanged<int> onChangePanel;

  const _DetailsAccordion({
    required this.expandedPanel,
    required this.onChangePanel,
  });

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: Colors.grey[300]!);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border(
          top: borderSide,
          bottom: borderSide,
          left: borderSide,
          right: borderSide,
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          _AccordionItem(
            title: "Product Description",
            index: 0,
            expandedIndex: expandedPanel,
            onTap: onChangePanel,
            child: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "Experience the perfect blend of style and comfort. "
                "Made from 100% premium pima cotton, this tee offers a soft, "
                "luxurious feel against your skin. Its classic V-neck cut and "
                "tailored fit make it a versatile piece for any occasion.",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          _AccordionItem(
            title: "Specifications",
            index: 1,
            expandedIndex: expandedPanel,
            onTap: onChangePanel,
            child: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "• 100% Pima cotton\n"
                "• Machine wash cold\n"
                "• Do not bleach\n"
                "• Tumble dry low\n"
                "• Made in Turkey",
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
            ),
          ),
          const Divider(height: 1),
          _AccordionItem(
            title: "Shipping & Returns",
            index: 2,
            expandedIndex: expandedPanel,
            onTap: onChangePanel,
            child: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "Free standard shipping on orders over \$50. "
                "Easy 30-day returns on unworn items with original tags attached.",
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccordionItem extends StatelessWidget {
  final String title;
  final int index;
  final int expandedIndex;
  final ValueChanged<int> onTap;
  final Widget child;

  const _AccordionItem({
    required this.title,
    required this.index,
    required this.expandedIndex,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bool isExpanded = index == expandedIndex;

    return InkWell(
      onTap: () => onTap(isExpanded ? -1 : index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 18,
                  color: Colors.grey[700],
                ),
              ],
            ),
            if (isExpanded) child,
          ],
        ),
      ),
    );
  }
}

// =========================
// Reviews Section
// =========================

class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection();

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Customer Reviews", style: titleStyle),
        const SizedBox(height: 8),
        Row(
          children: [
            Wrap(
              spacing: 2,
              children: List.generate(
                5,
                (index) =>
                    const Icon(Icons.star, size: 18, color: Color(0xFFFACC15)),
              ),
            ),
            const SizedBox(width: 8),
            const Text("4.0", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            const Text(
              "out of 5",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Spacer(),
            const Text(
              "Based on 121 reviews",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Write a review",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _ReviewCard(
          title: "Absolutely perfect!",
          rating: 5,
          author: "Jane D.",
          date: "Oct 24, 2023",
          body:
              "The fabric is incredibly soft and the fit is just right. I've already bought it in two more colors. Highly recommend for a high-quality basic tee.",
        ),
        const SizedBox(height: 12),
        _ReviewCard(
          title: "Great value",
          rating: 4,
          author: "Mark T.",
          date: "Oct 15, 2023",
          body:
              "Good quality for the price. It shrunk a little in the wash, so maybe size up if you're between sizes. Overall, very happy with my purchase.",
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String title;
  final int rating;
  final String author;
  final String date;
  final String body;

  const _ReviewCard({
    required this.title,
    required this.rating,
    required this.author,
    required this.date,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.grey[300]!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 2,
            children: List.generate(
              5,
              (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                size: 16,
                color: const Color(0xFFFACC15),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            "$author on $date",
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(body, style: const TextStyle(fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}

// =========================
// You Might Also Like
// =========================

class YouMightAlsoLikeSection extends StatelessWidget {
  final Map<String, dynamic> currentProduct;
  final List<Map<String, dynamic>> allProducts;

  const YouMightAlsoLikeSection({
    super.key,
    required this.currentProduct,
    required this.allProducts,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final colors = Theme.of(context).extension<AppColors>()!;

    // فلترة المنتجات المشابهة حسب نفس التصنيف
    final category = currentProduct["category"];
    final related = allProducts
        .where(
          (p) => p["id"] != currentProduct["id"] && p["category"] == category,
        )
        .take(10)
        .toList();

    if (related.isEmpty) {
      return const SizedBox(); // لا يوجد منتجات مشابهة
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).productYouMightAlsoLike,
          style: TextStyle(color: colors.textPrimary),
        ),
        const SizedBox(height: 16),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: related.map((p) {
              return Padding(
                padding: EdgeInsets.only(right: isMobile ? 12 : 16),
                child: _ProductCard(product: p, allProducts: allProducts),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final List<Map<String, dynamic>> allProducts;

  const _ProductCard({required this.product, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = product["image"] ?? "";
    final String title = product["name"] ?? "";
    final String category = product["category"] ?? "";
    final double price = (product["price"] ?? 0).toDouble();

    final colors = Theme.of(context).extension<AppColors>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ProductPage(product: product, allProducts: allProducts),
          ),
        );
      },
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.textSecondary.withOpacity(0.2)),
          color: colors.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------
            // IMAGE
            // ----------------------------
            AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _placeholder(title, colors, isDark),
                      )
                    : _placeholder(title, colors, isDark),
              ),
            ),

            // ----------------------------
            // TEXTS
            // ----------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Category
                  Text(
                    category,
                    style: TextStyle(fontSize: 11, color: colors.textSecondary),
                  ),
                  const SizedBox(height: 8),

                  // Price
                  Text(
                    price.toStringAsFixed(2),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // PLACEHOLDER (ثيم متوافق + أفضل من Colors.primaries)
  // =========================================================
  Widget _placeholder(String title, AppColors colors, bool isDark) {
    // هل الاسم عربي؟
    final bool isArabic = RegExp(r'^[\u0600-\u06FF]').hasMatch(title);

    // استخراج حروف
    String initials;
    if (title.isEmpty) {
      initials = "?";
    } else if (isArabic) {
      initials = title.substring(0, 1);
    } else {
      initials = title.length >= 2
          ? title.substring(0, 2).toUpperCase()
          : title.substring(0, 1).toUpperCase();
    }

    // لون placeholder من اللون الأساسي لكن باهت
    final Color bgColor = isDark
        ? colors.primary.withOpacity(0.20)
        : colors.primary.withOpacity(0.10);

    return Container(
      color: bgColor,
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDark ? colors.textPrimary : colors.primary,
          ),
        ),
      ),
    );
  }
}

class ExpandedSection extends StatelessWidget {
  final Widget child;
  const ExpandedSection({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, child: child);
  }
}
