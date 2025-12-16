import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/menu/MenuPage/customWebAppBar/customWebAppBar.dart';
import 'package:menuweb/menu/Retail_menu/footerSection/footersection.dart';
import 'package:menuweb/menu/Retail_menu/product_details_page/product_details_page.dart';
import 'package:menuweb/menu/Retail_menu/retail_sections/retail_sections.dart';
import 'package:menuweb/generated/l10n.dart';

class StoreHomePage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> offers;
  const StoreHomePage({
    super.key,
    required this.products,
    required this.offers,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        bool isMobile = width < 768;
        bool isTablet = width >= 768 && width < 1100;
        // bool isDesktop = width >= 1100;

        double horizontalPadding;
        if (isMobile) {
          horizontalPadding = 16;
        } else if (isTablet) {
          horizontalPadding = 32;
        } else {
          horizontalPadding = 64;
        }

        final sections = RetailSections(products: products);

        final newArrivals = sections.getNewArrivals();
        final categories = sections.getCategories();
        final bestSellers = sections.getBestSellers();

        return Scaffold(
          appBar: customWebAppBar(context),
          backgroundColor: colors.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                _HeroSection(
                  horizontalPadding: horizontalPadding,
                  isMobile: isMobile,
                  isTablet: isTablet,
                ),
                const SizedBox(height: 32),
                _NewArrivalsSection(
                  horizontalPadding: horizontalPadding,
                  isMobile: isMobile,
                  isTablet: isTablet,
                  items: newArrivals,
                  allProducts: products, // ← الآن أصبح صحيح
                ),

                const SizedBox(height: 32),
                _ShopByCategorySection(
                  horizontalPadding: horizontalPadding,
                  isMobile: isMobile,
                  isTablet: isTablet,
                  categories: categories,
                  allProducts: products,
                ),
                const SizedBox(height: 32),
                _BestSellersSection(
                  horizontalPadding: horizontalPadding,
                  isMobile: isMobile,
                  isTablet: isTablet,
                  items: bestSellers,
                ),
                const SizedBox(height: 48),
                FooterSection(
                  horizontalPadding: horizontalPadding,
                  isMobile: isMobile,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// ----------------------
/// HERO SECTION
/// ----------------------
class _HeroSection extends StatelessWidget {
  final double horizontalPadding;
  final bool isMobile;
  final bool isTablet;

  const _HeroSection({
    required this.horizontalPadding,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // <--- intl instance

    double height;
    if (isMobile) {
      height = 260;
    } else if (isTablet) {
      height = 300;
    } else {
      height = 340;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E3A8A), Color(0xFF312E81), Color(0xFF7C3AED)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ----------------------------
                // TITLE
                // ----------------------------
                Text(
                  s.heroTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 26 : 36,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 16),

                // ----------------------------
                // SUBTITLE
                // ----------------------------
                Text(
                  s.heroSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: isMobile ? 13 : 14,
                  ),
                ),

                const SizedBox(height: 24),

                // ----------------------------
                // CTA BUTTON
                // ----------------------------
                /*ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2563EB),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    s.heroButton,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ----------------------
/// NEW ARRIVALS
/// ----------------------
class _NewArrivalsSection extends StatelessWidget {
  final double horizontalPadding;
  final bool isMobile;
  final bool isTablet;
  final List<Map<String, dynamic>> allProducts;
  final List<Map<String, dynamic>> items;

  const _NewArrivalsSection({
    required this.horizontalPadding,
    required this.isMobile,
    required this.isTablet,
    required this.items,
    required this.allProducts,
  });

  int _crossAxisCount() {
    if (isMobile) return 2;
    if (isTablet) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).newArrivals,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: isMobile ? 1.0 : 1.3,
            ),
            itemBuilder: (context, index) {
              final p = items[index];

              return GestureDetector(
                onTap: () {
                  /* Navigator.pushNamed(
                    context,
                    "/productDetails",
                    arguments: p, // product كامل
                  );*/
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        product: p,
                        allProducts: allProducts, // ← هنا السحر
                      ),
                    ),
                  );
                },
                child: _ProductCard(
                  data: _ProductCardData(
                    title: p["name"] ?? "",
                    price: p["hasOffer"] == true
                        ? "${p["offerPrice"]} JD"
                        : "${p["price"]} JD",
                    imageUrl: p["image"] ?? "",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProductCardData {
  final String title;
  final String price;
  final String imageUrl;

  const _ProductCardData({
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}

class _ProductCard extends StatelessWidget {
  final _ProductCardData data;

  const _ProductCard({required this.data});

  @override
  @override
  Widget build(BuildContext context) {
    final hasImage = data.imageUrl.isNotEmpty;
    final colors = Theme.of(context).extension<AppColors>()!;

    return Container(
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
          // 🎨 صورة أو Placeholder ملوّن
          // ==============================
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: hasImage
                  ? Image.network(
                      data.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholder(),
                    )
                  : _placeholder(),
            ),
          ),

          const SizedBox(height: 8),

          // ==============================
          // اسم المنتج
          // ==============================
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 4.0,
            ),
            child: Text(
              data.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
            child: Text(
              data.price,
              style: TextStyle(fontSize: 12, color: colors.textPrimary),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // -----------------------------
  // 🟣 Placeholder ملون مع اسم المنتج
  // -----------------------------
  Widget _placeholder() {
    // أول حرفين من الاسم
    final initials = data.title.isNotEmpty
        ? data.title.length >= 2
              ? data.title.substring(0, 2).toUpperCase()
              : data.title.substring(0, 1).toUpperCase()
        : "?";

    // لون عشوائي ثابت بناءً على اسم المنتج
    final color = Colors
        .primaries[data.title.hashCode % Colors.primaries.length]
        .shade300;

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

/// ----------------------
/// SHOP BY CATEGORY
/// ----------------------
class _ShopByCategorySection extends StatelessWidget {
  final double horizontalPadding;
  final bool isMobile;
  final bool isTablet;

  // جاي من RetailSections.getCategories()
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> allProducts;
  const _ShopByCategorySection({
    required this.horizontalPadding,
    required this.isMobile,
    required this.isTablet,
    required this.categories,
    required this.allProducts,
  });

  int _crossAxisCount() {
    if (isMobile) return 2;
    if (isTablet) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).shopByCategory,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: isMobile ? 2.0 : 2.5,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final c = categories[index];

              return _CategoryCard(
                data: _CategoryCardData(
                  title: c["name"] ?? "",
                  imageUrl: c["image"] ?? "",
                  products: allProducts
                      .where((p) => p["category"] == c["name"])
                      .toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryCardData {
  final String title;
  final String imageUrl;
  final List<Map<String, dynamic>> products;

  const _CategoryCardData({
    required this.title,
    required this.imageUrl,
    required this.products,
  });
}

class _CategoryCard extends StatelessWidget {
  final _CategoryCardData data;

  const _CategoryCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final hasImage = data.imageUrl.isNotEmpty;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/categoryProducts",
          arguments: {
            "category": data.title,
            "products": data.products, // 👈 جاهزة الآن
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            hasImage
                ? Image.network(
                    data.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholder(),
                  )
                : _placeholder(),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.45), Colors.transparent],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(color: Colors.grey.shade300);
  }
}

/// ----------------------
/// BEST SELLERS
/// ----------------------
class _BestSellersSection extends StatelessWidget {
  final double horizontalPadding;
  final bool isMobile;
  final bool isTablet;

  // جاي من RetailSections.getBestSellers()
  final List<Map<String, dynamic>> items;

  const _BestSellersSection({
    required this.horizontalPadding,
    required this.isMobile,
    required this.isTablet,
    required this.items,
  });

  int _crossAxisCount() {
    if (isMobile) return 1;
    if (isTablet) return 2;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).BestSellers,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: isMobile ? 1.0 : 1.1,
            ),
            itemBuilder: (context, index) {
              final p = items[index];

              return _ProductCard(
                data: _ProductCardData(
                  title: p["name"] ?? "",
                  price: p["hasOffer"] == true
                      ? "${p["offerPrice"]} JD"
                      : "${p["price"]} JD",
                  imageUrl: p["image"] ?? "",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
