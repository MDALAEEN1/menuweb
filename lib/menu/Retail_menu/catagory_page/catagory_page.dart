import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/menu/MenuPage/customWebAppBar/customWebAppBar.dart';
import 'package:menuweb/menu/Retail_menu/footerSection/footersection.dart';
import 'package:menuweb/menu/Retail_menu/product_details_page/product_details_page.dart';

class ShirtsPage extends StatelessWidget {
  final Map? args;

  const ShirtsPage({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    if (args == null) {
      return const Scaffold(
        body: Center(child: Text("Category data is missing!")),
      );
    }

    final String category = args!["category"];
    final List<Map<String, dynamic>> products = List<Map<String, dynamic>>.from(
      args!["products"],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        // -------------------------------
        // نفس النظام المستخدم في StoreHomePage
        // -------------------------------
        final bool isMobile = width < 768;
        final bool isTablet = width >= 768 && width < 1100;

        double horizontalPadding;
        if (isMobile) {
          horizontalPadding = 16;
        } else if (isTablet) {
          horizontalPadding = 32;
        } else {
          horizontalPadding = 64;
        }

        return Scaffold(
          appBar: customWebAppBar(context),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                // --- العنوان ---
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 24,
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ),

                // --- الجريد ---
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile
                          ? 2
                          : isTablet
                          ? 3
                          : 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.78,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = products[index];
                      return _ProductCard(
                        data: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductPage(
                                product: product,
                                allProducts: products,
                              ),
                            ),
                          );
                        },
                      );
                    }, childCount: products.length),
                  ),
                ),

                // --- الفوتر ---
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      FooterSection(
                        horizontalPadding: horizontalPadding,
                        isMobile: isMobile,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/* ============================================================
    PRODUCT CARD — نفس ستايل الصفحة الرئيسية
============================================================ */

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;

  const _ProductCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    final title = data["name"] ?? "";
    final image = data["image"] ?? "";
    final double price = (data["offerPrice"] ?? data["price"] ?? 0).toDouble();
    final double? oldPrice = data["hasOffer"] == true
        ? (data["price"] ?? 0).toDouble()
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==============================
            // صورة أو placeholder ملوّن
            // ==============================
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: image.isNotEmpty
                    ? Image.network(
                        image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(title),
                      )
                    : _placeholder(title),
              ),
            ),

            const SizedBox(height: 8),

            // ==============================
            // الاسم
            // ==============================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 4.0,
              ),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
            ),

            // ==============================
            // السعر
            // ==============================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 4.0,
              ),
              child: Row(
                children: [
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (oldPrice != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      "\$${oldPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ==============================
  // Placeholder بنفس الشكل السابق
  // ==============================
  Widget _placeholder(String title) {
    final initials = title.isNotEmpty
        ? (title.length >= 2
              ? title.substring(0, 2).toUpperCase()
              : title.substring(0, 1).toUpperCase())
        : "?";

    final color =
        Colors.primaries[title.hashCode % Colors.primaries.length].shade300;

    return Container(
      width: double.infinity,
      color: color,
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
