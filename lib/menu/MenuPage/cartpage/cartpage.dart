import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/menu/MenuPage/cartpage/cart_service.dart';
import 'package:menuweb/menu/MenuPage/customWebAppBar/customWebAppBar.dart';
import 'package:menuweb/generated/l10n.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final cartItems = CartService.getItems();
    final subtotal = CartService.subtotal();
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: customWebAppBar(context),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : _buildCartWithItems(isMobile, cartItems, subtotal),
    );
  }

  Widget _buildEmptyCart() {
    final colors = Theme.of(context).extension<AppColors>()!;
    final s = S.of(context); // intl

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: colors.textSecondary.withOpacity(0.3),
          ),

          const SizedBox(height: 20),

          // ---------------------------
          // العنوان
          // ---------------------------
          Text(
            s.cartEmptyTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),

          const SizedBox(height: 10),

          // ---------------------------
          // الوصف
          // ---------------------------
          Text(
            s.cartEmptySubtitle,
            style: TextStyle(fontSize: 16, color: colors.textSecondary),
          ),

          const SizedBox(height: 30),

          // ---------------------------
          // زر التصفح
          // ---------------------------
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.background,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              s.cartEmptyBrowse,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartWithItems(bool isMobile, List cartItems, double subtotal) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: isMobile
          ? _buildMobileLayout(cartItems, subtotal)
          : _buildDesktopLayout(cartItems, subtotal),
    );
  }

  // =============================
  // DESKTOP / TABLET LAYOUT
  // =============================
  Widget _buildDesktopLayout(List cartItems, double subtotal) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildCartList(cartItems)),
        const SizedBox(width: 24),
        Expanded(flex: 1, child: _buildSummary(subtotal, cartItems.length)),
      ],
    );
  }

  // =============================
  // MOBILE LAYOUT
  // =============================
  Widget _buildMobileLayout(List cartItems, double subtotal) {
    return Column(
      children: [
        Expanded(child: _buildCartList(cartItems)),
        const SizedBox(height: 20),
        _buildSummary(subtotal, cartItems.length),
      ],
    );
  }

  // =============================
  // CART LIST
  // =============================
  Widget _buildCartList(List cartItems) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ------------------------
            // العنوان (مع عدد المنتجات)
            // ------------------------
            Text(
              s.cartTitle(cartItems.length.toString()),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),

            // ------------------------
            // مسح الكل (إذا ليست فارغة)
            // ------------------------
            if (cartItems.isNotEmpty)
              TextButton.icon(
                onPressed: () => _showClearCartDialog(),
                icon: Icon(Icons.delete_outline, size: 18, color: colors.error),
                label: Text(
                  s.cartClearAll,
                  style: TextStyle(color: colors.error),
                ),
                style: TextButton.styleFrom(foregroundColor: colors.error),
              ),
          ],
        ),

        const SizedBox(height: 16),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: cartItems.length,
            itemBuilder: (context, i) {
              final item = cartItems[i];
              return _buildCartItem(item, i);
            },
          ),
        ),
      ],
    );
  }

  // =============================
  // CART ITEM
  // =============================
  Widget _buildCartItem(Map item, int i) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;
    final colors = Theme.of(context).extension<AppColors>()!;

    return Dismissible(
      key: Key(item["id"]?.toString() ?? i.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: colors.warning, size: 28),
      ),
      confirmDismiss: (direction) async {
        return await _showDeleteDialog(i);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isMobile
            ? _buildMobileItem(item, i)
            : _buildDesktopItem(item, i),
      ),
    );
  }

  // =============================
  // MOBILE ITEM DESIGN
  // =============================
  Widget _buildMobileItem(Map item, int i) {
    final totalPrice = (item["price"] * item["qty"]);
    final colors = Theme.of(context).extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productImage(item, size: 80),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (item["description"] != null && item["description"] != "")
                    Text(
                      item["description"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.textSecondary,
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_qtyButtons(i, item), _deleteButton(i)],
        ),
      ],
    );
  }

  // =============================
  // DESKTOP ITEM DESIGN
  // =============================
  Widget _buildDesktopItem(Map item, int i) {
    final totalPrice = (item["price"] * item["qty"]);

    return Row(
      children: [
        _productImage(item, size: 80),
        const SizedBox(width: 16),
        Expanded(child: _productInfo(item)),
        Text(
          "\$${item["price"].toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 20),
        _qtyButtons(i, item),
        const SizedBox(width: 20),
        Text(
          "\$${totalPrice.toStringAsFixed(2)}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        _deleteButton(i),
      ],
    );
  }

  // =============================
  // PRODUCT IMAGE
  // =============================
  Widget _productImage(Map item, {double size = 80}) {
    final String img = item["image"] ?? "";
    final bool noImage =
        img.isEmpty || img.contains("noimage") || img == "null";

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: noImage ? Colors.blue.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: noImage
          ? Center(
              child: Text(
                item["name"].substring(0, 2).toUpperCase(),
                style: TextStyle(
                  fontSize: size * 0.25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade600,
                ),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                img,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: size * 0.4,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
    );
  }

  // =============================
  // TEXT INFO
  // =============================
  Widget _productInfo(Map item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item["name"],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        if (item["description"] != null && item["description"] != "")
          Text(
            item["description"],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        const SizedBox(height: 8),
        if (item["color"] != null && item["color"] != "")
          Row(
            children: [
              Text(
                "اللون: ",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _parseColor(item["color"]),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                item["color"],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ),
      ],
    );
  }

  Color _parseColor(String colorString) {
    try {
      if (colorString.startsWith('0x')) {
        return Color(int.parse(colorString));
      } else if (colorString.startsWith('#')) {
        return Color(
          int.parse(colorString.substring(1), radix: 16) + 0xFF000000,
        );
      } else {
        return Color(int.parse(colorString));
      }
    } catch (e) {
      return Colors.grey;
    }
  }

  // =============================
  // QTY BUTTONS
  // =============================
  Widget _qtyButtons(int i, Map item) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      decoration: BoxDecoration(
        color: colors.textPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              if (item["qty"] > 1) {
                CartService.updateQty(i, item["qty"] - 1);
                refresh();
              }
            },
            icon: Icon(Icons.remove, size: 18, color: colors.textPrimary),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          Container(
            width: 40,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "${item["qty"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              CartService.updateQty(i, item["qty"] + 1);
              refresh();
            },
            icon: Icon(Icons.add, size: 18, color: colors.textPrimary),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }

  // =============================
  // DELETE BUTTON
  // =============================
  Widget _deleteButton(int index) {
    return IconButton(
      onPressed: () => _showDeleteDialog(index),
      icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
      tooltip: "حذف",
    );
  }

  // =============================
  // SUMMARY BOX
  // =============================
  Widget _buildSummary(double subtotal, int itemCount) {
    final shipping = 0.0;
    final tax = subtotal * 0.0;
    final total = subtotal + shipping + tax;

    final colors = Theme.of(context).extension<AppColors>()!;
    final s = S.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------------- Title ----------------------
          Text(
            s.summaryTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),

          const SizedBox(height: 20),

          // ---------------------- Rows ----------------------
          _summaryRow(
            s.summarySubtotal(itemCount.toString()),
            subtotal,
            colors,
          ),
          _summaryRow(s.summaryShipping, shipping, colors),
          _summaryRow(s.summaryTax, tax, colors),

          const Divider(height: 30),

          _summaryRow(s.summaryTotal, total, colors),

          const SizedBox(height: 25),

          // ---------------------- Checkout Button ----------------------
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/Checkout");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.background,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.summaryCheckout,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 20, color: colors.background),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ---------------------- Note ----------------------
          Text(
            s.summaryNote,
            style: TextStyle(fontSize: 12, color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    double value,
    AppColors colors, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ----------------------------
          // Label
          // ----------------------------
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? colors.textPrimary : colors.textSecondary,
            ),
          ),

          // ----------------------------
          // Value
          // ----------------------------
          Text(
            "\$${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isBold ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? colors.primary : colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // =============================
  // DIALOGS
  // =============================
  Future<bool> _showDeleteDialog(int index) async {
    final s = S.of(context);
    final colors = Theme.of(context).extension<AppColors>()!;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          s.deleteProduct,
          style: TextStyle(color: colors.textPrimary),
        ),
        content: Text(
          s.deleteProductConfirm,
          style: TextStyle(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(s.cancel, style: TextStyle(color: colors.textPrimary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: colors.error),
            child: Text(s.delete),
          ),
        ],
        backgroundColor: colors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    if (result == true) {
      CartService.deleteItem(index);
      refresh();
    }

    return result ?? false;
  }

  void _showClearCartDialog() async {
    final s = S.of(context);
    final colors = Theme.of(context).extension<AppColors>()!;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.clearCart, style: TextStyle(color: colors.textPrimary)),
        content: Text(
          s.clearCartConfirm,
          style: TextStyle(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(s.cancel, style: TextStyle(color: colors.textPrimary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: colors.error),
            child: Text(s.clearAll),
          ),
        ],
        backgroundColor: colors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    if (result == true) {
      CartService.clear();
      refresh();
    }
  }
}
