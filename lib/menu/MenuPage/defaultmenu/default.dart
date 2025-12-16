import 'package:flutter/material.dart';
import 'package:menuweb/menu/MenuPage/cartpage/cart_service.dart';
import 'package:menuweb/menu/MenuPage/customWebAppBar/customWebAppBar.dart';

class DefaultUIPage extends StatefulWidget {
  final String designKey;
  final List<Map<String, dynamic>> products;

  const DefaultUIPage({
    super.key,
    required this.designKey,
    required this.products,
  });

  @override
  State<DefaultUIPage> createState() => _DefaultUIPageState();
}

class _DefaultUIPageState extends State<DefaultUIPage> {
  int pageIndex = 0;
  final int productsPerPage = 8;
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int totalPages = (widget.products.length / productsPerPage).ceil();

    int start = pageIndex * productsPerPage;
    int end = (start + productsPerPage);
    if (end > widget.products.length) end = widget.products.length;

    List<Map<String, dynamic>> currentProducts = widget.products.sublist(
      start,
      end,
    );

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: customWebAppBar(context),

      body: LayoutBuilder(
        builder: (context, constraints) {
          double aspectRatio = getAspectRatio(screenWidth);
          int columns = getColumns(screenWidth);

          return Column(
            children: [
              const SizedBox(height: 20),

              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1200,
                      minWidth: 350,
                    ),
                    child: GridView.builder(
                      itemCount: currentProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: aspectRatio,
                      ),
                      itemBuilder: (context, i) {
                        final p = currentProducts[i];
                        return MouseRegion(
                          onEnter: (_) => setState(() => _hoveredIndex = i),
                          onExit: (_) => setState(() => _hoveredIndex = null),
                          child: AnimatedScale(
                            duration: const Duration(milliseconds: 200),
                            scale: _hoveredIndex == i ? 1.02 : 1.0,
                            child: buildProductCard(p),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Pagination محسّن
              _buildPagination(totalPages),
              const SizedBox(height: 25),
            ],
          );
        },
      ),
    );
  }

  // -------------------------------------------------
  // PAGINATION محسّن
  // -------------------------------------------------
  Widget _buildPagination(int totalPages) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // زر السابق
          if (pageIndex > 0)
            IconButton(
              onPressed: () => setState(() => pageIndex--),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.chevron_left,
                  size: 20,
                  color: Colors.grey.shade700,
                ),
              ),
            ),

          // الأرقام
          Row(
            children: List.generate(totalPages, (i) {
              bool active = (i == pageIndex);
              return InkWell(
                onTap: () => setState(() => pageIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: active ? Colors.blue.shade600 : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: active
                          ? Colors.blue.shade600
                          : Colors.grey.shade300,
                    ),
                    boxShadow: active
                        ? [
                            BoxShadow(
                              color: Colors.blue.shade200,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Text(
                    "${i + 1}",
                    style: TextStyle(
                      color: active ? Colors.white : Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }),
          ),

          // زر التالي
          if (pageIndex < totalPages - 1)
            IconButton(
              onPressed: () => setState(() => pageIndex++),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // -------------------------------------------------
  // PRODUCT CARD محسّن
  // -------------------------------------------------
  Widget buildProductCard(Map<String, dynamic> p) {
    final String name = p["name"] ?? "";
    final String desc = p["description"] ?? "";
    final dynamic price = p["price"] ?? 0;
    final String imageUrl = p["image"] ?? "";
    final bool hasOffer = p["hasOffer"] ?? false;
    final dynamic offerPrice = p["offerPrice"];

    final bool hasImage = imageUrl.isNotEmpty;

    // Format price
    String formattedPrice = (price is num)
        ? "\$${price.toStringAsFixed(2)}"
        : "\$${double.tryParse(price.toString())?.toStringAsFixed(2) ?? price.toString()}";

    String formattedOfferPrice = (offerPrice is num)
        ? "\$${offerPrice.toStringAsFixed(2)}"
        : "\$${double.tryParse(offerPrice.toString())?.toStringAsFixed(2) ?? offerPrice.toString()}";

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/productDetails", arguments: p);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE WITH OFFER BADGE
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        color: Colors.grey.shade100,
                        child: hasImage
                            ? Image.network(
                                imageUrl,
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildPlaceholder(name);
                                },
                              )
                            : _buildPlaceholder(name),
                      ),
                    ),

                    // OFFER BADGE
                    if (hasOffer)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade500,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.shade300,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            "عرض خاص",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    // HOVER EFFECT
                    Positioned.fill(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: _hoveredIndex != null
                              ? Colors.black.withOpacity(0.03)
                              : Colors.transparent,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.visibility,
                            color: Colors.transparent,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // TEXT CONTENT
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Expanded(
                          child: Text(
                            desc,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              height: 1.4,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // PRICE + ADD BUTTON
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (hasOffer)
                                    Text(
                                      formattedPrice,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade500,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  Text(
                                    hasOffer
                                        ? formattedOfferPrice
                                        : formattedPrice,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: hasOffer
                                          ? Colors.green.shade600
                                          : Colors.blue.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ADD BUTTON
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.blue.shade100,
                                  width: 1.5,
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.blue.shade700,
                                  size: 20,
                                ),
                                onPressed: () {
                                  _addToCart(p);
                                },
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------
  // PLACEHOLDER WIDGET
  // -------------------------------------------------
  Widget _buildPlaceholder(String name) {
    return Container(
      color: Colors.blue.shade50,
      child: Center(
        child: Text(
          name.isNotEmpty ? name.substring(0, 2) : "NA",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade600,
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------
  // ADD TO CART FUNCTION
  // -------------------------------------------------
  void _addToCart(Map<String, dynamic> product) {
    // هنا يمكنك إضافة منطق إضافة المنتج للسلة
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم إضافة ${product["name"]} إلى السلة'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // -------------------------------------------------
  // RESPONSIVE DESIGN HELPERS
  // -------------------------------------------------
  double getAspectRatio(double screenWidth) {
    if (screenWidth > 1200) return 0.75;
    if (screenWidth > 900) return 0.80;
    if (screenWidth > 600) return 0.85;
    return 0.95;
  }

  int getColumns(double screenWidth) {
    if (screenWidth > 1200) return 4;
    if (screenWidth > 900) return 3;
    if (screenWidth > 600) return 2;
    return 1;
  }
}
