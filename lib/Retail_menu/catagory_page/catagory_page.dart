import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/MenuPage/customWebAppBar/customWebAppBar.dart';
import 'package:menuweb/Retail_menu/footerSection/footersection.dart';
import 'package:menuweb/Retail_menu/product_details_page/product_details_page.dart';

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
        final bool isDesktop = width >= 1100;

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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          if (isDesktop)
                            const SizedBox(
                              width: 260,
                              child: _SidebarFilters(),
                            ),

                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                                vertical: 24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: colors.textPrimary,
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  // Products Grid
                                  Expanded(
                                    child: _ProductsGrid(
                                      products: products,
                                      maxWidth:
                                          constraints.maxWidth -
                                          (isDesktop ? 260 : 0),
                                      isMobile: isMobile,
                                      isTablet: isTablet,
                                      isDesktop: isDesktop,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // FOOTER SECTION — تمت إضافته هنا ✔
                    FooterSection(
                      horizontalPadding: horizontalPadding,
                      isMobile: isMobile,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/* ============================================================
    GRID VIEW BUILDER — نفس طريقة StoreHomePage
============================================================ */

class _ProductsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final double maxWidth;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const _ProductsGrid({
    required this.products,
    required this.maxWidth,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });

  int get crossAxisCount {
    if (isMobile) return 2;
    if (isTablet) return 3;
    return 4; // desktop
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return _ProductCard(
          data: product,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ProductPage(product: product, allProducts: products),
              ),
            );
          },
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
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: image.isNotEmpty
                    ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(title),
                      )
                    : _placeholder(title),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder(String title) {
    final letter = title.isNotEmpty ? title[0].toUpperCase() : "?";
    return Container(
      color: Colors.grey.shade300,
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            fontSize: 34,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/* ============================================================
    SIDEBAR
============================================================ */

class _SidebarFilters extends StatelessWidget {
  const _SidebarFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
