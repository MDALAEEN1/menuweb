import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/menu/MenuPage/cartpage/cart_service.dart';
import 'package:menuweb/generated/l10n.dart';

import 'checkout_service.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String fulfillmentMethod = "delivery";
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController promoController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    notesController.dispose();
    promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final items = CartService.getItems();
    final subtotal = CartService.subtotal();
    final shipping = fulfillmentMethod == "delivery" ? 0.0 : 0.0;
    final taxes = subtotal * 0.00; // 10% ضريبة (هنا 0 كـ placeholder)
    final total = subtotal + shipping + taxes;

    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 750;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          S.of(context).checkoutTitle,
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colors.card,
        elevation: 0.5,
        iconTheme: IconThemeData(color: colors.textPrimary),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: isMobile
                    ? _buildMobile(
                        items,
                        subtotal,
                        shipping,
                        taxes,
                        total,
                        colors,
                      )
                    : _buildDesktop(
                        items,
                        subtotal,
                        shipping,
                        taxes,
                        total,
                        colors,
                      ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ==============================================================================================
  // DESKTOP / TABLET VIEW
  // ==============================================================================================
  Widget _buildDesktop(
    List items,
    double subtotal,
    double shipping,
    double taxes,
    double total,
    AppColors colors,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT SECTION — SCROLLABLE
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: _leftSection(
              items,
              subtotal,
              shipping,
              taxes,
              total,
              colors,
            ),
          ),
        ),
        const SizedBox(width: 24),

        // RIGHT SECTION — SUMMARY BOX
        Expanded(
          flex: 1,
          child: _rightSection(items, subtotal, shipping, taxes, total, colors),
        ),
      ],
    );
  }

  // ==============================================================================================
  // MOBILE VIEW
  // ==============================================================================================
  Widget _buildMobile(
    List items,
    double subtotal,
    double shipping,
    double taxes,
    double total,
    AppColors colors,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _leftSection(items, subtotal, shipping, taxes, total, colors),
          const SizedBox(height: 20),
          _rightSection(items, subtotal, shipping, taxes, total, colors),
        ],
      ),
    );
  }

  // ==============================================================================================
  // LEFT SECTION
  // ==============================================================================================
  Widget _leftSection(
    List items,
    double subtotal,
    double shipping,
    double taxes,
    double total,
    AppColors colors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Customer Details
        Card(
          color: colors.card,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              MediaQuery.of(context).size.width < 400 ? 16 : 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // طريقة الاستلام - قسم متجاوب
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width < 400 ? 12 : 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "طريقة الاستلام",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width < 400
                              ? 18
                              : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // تخطيط متجاوب - عمودي للشاشات الصغيرة، أفقي للكبيرة
                      MediaQuery.of(context).size.width < 500
                          ? Column(
                              children: [
                                _responsiveMethodCard(
                                  S.of(context).delivery,
                                  S.of(context).deliverySubtitle,
                                  Icons.local_shipping_outlined,
                                  fulfillmentMethod == "delivery",
                                  () => setState(
                                    () => fulfillmentMethod = "delivery",
                                  ),
                                  colors,
                                ),
                                const SizedBox(height: 12),
                                _responsiveMethodCard(
                                  S.of(context).pickup,
                                  S.of(context).pickupSubtitle,
                                  Icons.storefront_outlined,
                                  fulfillmentMethod == "pickup",
                                  () => setState(
                                    () => fulfillmentMethod = "pickup",
                                  ),
                                  colors,
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: _responsiveMethodCard(
                                    S.of(context).delivery,
                                    S.of(context).deliverySubtitle,
                                    Icons.local_shipping_outlined,
                                    fulfillmentMethod == "delivery",
                                    () => setState(
                                      () => fulfillmentMethod = "delivery",
                                    ),
                                    colors,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width < 600
                                      ? 12
                                      : 16,
                                ),
                                Expanded(
                                  child: _responsiveMethodCard(
                                    S.of(context).pickup,
                                    S.of(context).pickupSubtitle,
                                    Icons.storefront_outlined,
                                    fulfillmentMethod == "pickup",
                                    () => setState(
                                      () => fulfillmentMethod = "pickup",
                                    ),
                                    colors,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // معلومات العميل
                Text(
                  S.of(context).customerInfo,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 400 ? 18 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                _responsiveLabel(S.of(context).customerInfo, colors),
                _responsiveInput(nameController, S.of(context).fullNameHint),
                const SizedBox(height: 16),

                if (fulfillmentMethod == "delivery") ...[
                  _responsiveLabel(S.of(context).address, colors),
                  _responsiveInput(
                    addressController,
                    S.of(context).addressHint,
                  ),
                  const SizedBox(height: 16),
                ],

                _responsiveLabel(S.of(context).phoneNumber, colors),
                _responsiveInput(
                  phoneController,
                  S.of(context).phoneNumberHint,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                _responsiveLabel(S.of(context).notes, colors),
                _responsiveInput(
                  notesController,
                  S.of(context).notesHint,
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                Text(
                  S.of(context).notesExample,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 400 ? 11 : 12,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==================== بطاقة الطريقة المتجاوبة ====================
  Widget _responsiveMethodCard(
    String title,
    String subtitle,
    IconData icon,
    bool selected,
    VoidCallback onTap,
    AppColors colors,
  ) {
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 400;
    final bool isVerySmallScreen = width < 350;

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(
          isVerySmallScreen
              ? 12
              : isSmallScreen
              ? 14
              : 16,
        ),
        decoration: BoxDecoration(
          color: colors.card,
          border: Border.all(
            color: selected
                ? colors.primary
                : colors.textSecondary.withOpacity(0.3),
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? colors.primary
                  : colors.textSecondary.withOpacity(0.7),
              size: isVerySmallScreen
                  ? 20
                  : isSmallScreen
                  ? 22
                  : 24,
            ),
            SizedBox(
              width: isVerySmallScreen
                  ? 8
                  : isSmallScreen
                  ? 10
                  : 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- العنوان ----
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: selected ? colors.primary : colors.textPrimary,
                      fontSize: isVerySmallScreen
                          ? 14
                          : isSmallScreen
                          ? 15
                          : 16,
                    ),
                  ),

                  if (!isVerySmallScreen) const SizedBox(height: 4),

                  // ---- العنوان الفرعي ----
                  if (!isVerySmallScreen)
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 11 : 13,
                        color: selected
                            ? colors.primary.withOpacity(0.85)
                            : colors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),

            // ---- علامة الصح عند الاختيار ----
            if (selected)
              Icon(
                Icons.check_circle,
                color: colors.primary,
                size: isVerySmallScreen
                    ? 16
                    : isSmallScreen
                    ? 18
                    : 20,
              ),
          ],
        ),
      ),
    );
  }

  // ==================== التسمية المتجاوبة ====================
  Widget _responsiveLabel(String text, AppColors colors) {
    return Text(
      text,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width < 400 ? 14 : 15,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
    );
  }

  // ==================== حقل الإدخال المتجاوب ====================
  Widget _responsiveInput(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 400;
    final colors = Theme.of(context).extension<AppColors>()!;

    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: colors.card,
        contentPadding: EdgeInsets.all(isSmallScreen ? 14 : 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.textSecondary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.textSecondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
        ),
      ),
    );
  }

  // ==============================================================================================
  // RIGHT SECTION — ORDER SUMMARY
  // ==============================================================================================
  Widget _rightSection(
    List items,
    double subtotal,
    double shipping,
    double taxes,
    double total,
    AppColors colors,
  ) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width < 400 ? 16 : 20,
          ),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).orderSummary,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 400 ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // المنتجات
              for (var item in items) _orderItem(item),

              const Divider(height: 30),

              // التكاليف
              _summaryRow(S.of(context).subtotal, subtotal, colors),
              _summaryRow(S.of(context).shipping, shipping, colors),
              _summaryRow(S.of(context).tax, taxes, colors),
              const Divider(height: 30),

              // المجموع الكلي
              _summaryRow(S.of(context).total, total, colors, bold: true),
              const SizedBox(height: 20),

              // كود الخصم
              TextField(
                controller: promoController,
                decoration: InputDecoration(
                  hintText: S.of(context).promoCodeHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.discount_outlined,
                      size: MediaQuery.of(context).size.width < 400 ? 20 : 24,
                    ),
                    onPressed: () {
                      // تطبيق كود الخصم - منطق منفصل لاحقًا
                    },
                  ),
                  contentPadding: EdgeInsets.all(
                    MediaQuery.of(context).size.width < 400 ? 12 : 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // زر إتمام الطلب
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.width < 400 ? 50 : 56,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: Colors.grey.shade400,
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).placeOrder,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width < 400
                                    ? 14
                                    : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width < 400
                                  ? 6
                                  : 8,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: MediaQuery.of(context).size.width < 400
                                  ? 18
                                  : 20,
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                S.of(context).placeOrderAgreement,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 400 ? 10 : 12,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // معلومات آمنة
        Container(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width < 400 ? 12 : 16,
          ),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade100),
          ),
          child: Row(
            children: [
              Icon(
                Icons.security,
                color: Colors.green.shade600,
                size: MediaQuery.of(context).size.width < 400 ? 18 : 20,
              ),
              SizedBox(width: MediaQuery.of(context).size.width < 400 ? 6 : 8),
              Expanded(
                child: Text(
                  S.of(context).secureInfo,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 400 ? 10 : 12,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==============================================================================================
  // ORDER ITEM ROW
  // ==============================================================================================
  Widget _orderItem(Map item) {
    final totalPrice = (item["price"] * item["qty"]);
    final colors = Theme.of(context).extension<AppColors>()!;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(
        MediaQuery.of(context).size.width < 400 ? 10 : 12,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // الصورة
          Container(
            width: MediaQuery.of(context).size.width < 400 ? 40 : 50,
            height: MediaQuery.of(context).size.width < 400 ? 40 : 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              image: (item["image"] != null && item["image"] != "")
                  ? DecorationImage(
                      image: NetworkImage(item["image"]),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: (item["image"] == null || item["image"] == "")
                ? Icon(
                    Icons.image,
                    color: Colors.grey.shade400,
                    size: MediaQuery.of(context).size.width < 400 ? 16 : 20,
                  )
                : null,
          ),
          SizedBox(width: MediaQuery.of(context).size.width < 400 ? 8 : 12),

          // المعلومات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["name"],
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 400 ? 12 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  " ${item["qty"]}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 400 ? 10 : 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // السعر
          Text(
            "\$${totalPrice.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
              fontSize: MediaQuery.of(context).size.width < 400 ? 12 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String title,
    double value,
    AppColors colors, {
    bool bold = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final small = screenWidth < 400;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // ---- Label ----
          Text(
            title,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: bold ? colors.textPrimary : colors.textSecondary,
              fontSize: bold ? (small ? 14 : 16) : (small ? 12 : 14),
            ),
          ),

          const Spacer(),

          // ---- Value ----
          Text(
            "\$${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: bold ? colors.primary : colors.textPrimary,
              fontSize: bold ? (small ? 16 : 18) : (small ? 12 : 14),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================================================
  // PLACE ORDER FUNCTION (تستدعي service فقط)
  // ==============================================================================================
  Future<void> _placeOrder() async {
    final items = CartService.getItems();
    final colors = Theme.of(context).extension<AppColors>()!;
    final t = S.of(context);

    // التحقق من وجود منتجات
    if (items.isEmpty) {
      _showErrorSnackBar(t.cartEmptyError, colors);
      return;
    }

    // التحقق من الحقول المطلوبة
    if (nameController.text.trim().isEmpty) {
      _showErrorSnackBar(t.nameRequiredError, colors);
      return;
    }

    if (fulfillmentMethod == "delivery" &&
        addressController.text.trim().isEmpty) {
      _showErrorSnackBar(t.addressRequiredError, colors);
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      _showErrorSnackBar(t.phoneRequiredError, colors);
      return;
    }

    setState(() => isLoading = true);

    try {
      final result = await CheckoutService.placeOrder(
        fulfillmentMethod: fulfillmentMethod,
        name: nameController.text,
        phone: phoneController.text,
        address: addressController.text,
        notes: notesController.text,
        promoCode: promoController.text,
      );

      _showSuccessSnackBar(t.orderSuccess(result["orderNumber"]), colors);

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    } catch (e) {
      final msg = e.toString();
      if (msg == "no_items") {
        _showErrorSnackBar(t.cartEmptyError, colors);
      } else if (msg == "uid_not_found") {
        _showErrorSnackBar(t.userNotFoundError, colors);
      } else {
        _showErrorSnackBar(t.orderFailed(e), colors);
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showErrorSnackBar(String message, AppColors colors) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: colors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message, AppColors colors) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: colors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
