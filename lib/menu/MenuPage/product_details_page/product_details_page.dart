import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/menu/MenuPage/customWebAppBar/customWebAppBar.dart';

class ProductDetailsUI extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsUI({super.key, required this.product});

  @override
  State<ProductDetailsUI> createState() => _ProductDetailsUIState();
}

class _ProductDetailsUIState extends State<ProductDetailsUI> {
  int quantity = 1;
  int selectedImageIndex = 0;

  String selectedColor = "";
  String selectedSize = "Medium";

  double finalPrice = 0;

  @override
  void initState() {
    super.initState();

    // 1) السعر الأساسي يعتمد عالعرض
    final hasOffer = widget.product["hasOffer"] == true;
    final basePrice = hasOffer
        ? (widget.product["offerPrice"]?.toDouble() ??
              widget.product["price"]?.toDouble() ??
              0)
        : (widget.product["price"]?.toDouble() ?? 0);

    finalPrice = basePrice;

    // 2) اختيار اللون الافتراضي
    final colors = widget.product["colors"];
    if (colors != null && colors is List && colors.isNotEmpty) {
      selectedColor = colors[0].toString();
    } else {
      selectedColor = "";
    }

    // 3) اختيار الخيارات الافتراضية
    _initDefaultChoices();

    // 4) احسب السعر النهائي (العرض + الخيارات + الإضافات)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updatePrice();
    });
  }

  // ------------------------------------------------------
  // إعداد خيارات افتراضية
  // ------------------------------------------------------
  void _initDefaultChoices() {
    final p = widget.product;
    if (p["choices"] != null) {
      for (var group in p["choices"]) {
        if (group["items"] != null && group["items"].isNotEmpty) {
          group["selected"] = group["items"][0];
        }
      }
    }
  }

  // ------------------------------------------------------
  // تحديث السعر النهائي
  // ------------------------------------------------------
  void _updatePrice() {
    double base = widget.product["hasOffer"] == true
        ? (widget.product["offerPrice"]?.toDouble() ??
              widget.product["price"]?.toDouble() ??
              0)
        : (widget.product["price"]?.toDouble() ?? 0);

    double extra = 0;

    // Addons
    final addons = widget.product["addons"] ?? [];
    for (var a in addons) {
      if (a["selected"] == true) {
        extra += (a["extraPrice"] ?? 0);
      }
    }

    // Choices
    final choices = widget.product["choices"] ?? [];
    for (var g in choices) {
      if (g["selected"] != null) {
        extra += (g["selected"]["extraPrice"] ?? 0);
      }
    }

    setState(() => finalPrice = base + extra);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final p = widget.product;
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 800;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: customWebAppBar(context),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isMobile ? _mobileLayout(p) : _desktopLayout(p),
          ),
        ),
      ),
    );
  }

  // ------------------ DESKTOP LAYOUT ------------------

  Widget _desktopLayout(Map p) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _productImages(p)),
        const SizedBox(width: 30),
        Expanded(flex: 2, child: _productDetails(p)),
      ],
    );
  }

  // ------------------ MOBILE LAYOUT ------------------

  Widget _mobileLayout(Map p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _productImages(p),
        const SizedBox(height: 20),
        _productDetails(p),
      ],
    );
  }

  // ------------------------------------------------------
  // صور المنتج
  // ------------------------------------------------------

  Widget _productImages(Map p) {
    List images = p["images"] ?? [p["image"]];
    String name = p["name"] ?? "بدون اسم";

    bool hasImages = images.isNotEmpty && images[0] != null && images[0] != "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: hasImages
              ? Image.network(
                  images[selectedImageIndex],
                  height: 420,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 420,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey.shade300, Colors.grey.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
        ),

        const SizedBox(height: 16),

        if (hasImages)
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, i) => GestureDetector(
                onTap: () => setState(() => selectedImageIndex = i),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedImageIndex == i
                          ? Colors.blue
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      images[i],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ------------------------------------------------------
  // تفاصيل المنتج
  // ------------------------------------------------------

  Widget _productDetails(Map p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          p["name"],
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        Text(
          p["descriptionShort"] ?? "",
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),

        const SizedBox(height: 20),

        Text(
          "\$${finalPrice.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        _colorSelector(p),
        const SizedBox(height: 20),

        if (p["addons"] != null && p["addons"].isNotEmpty) _addonsSection(p),
        const SizedBox(height: 20),

        if (p["choices"] != null && p["choices"].isNotEmpty) _choicesSection(p),
        const SizedBox(height: 20),

        _qtyAddButton(p),
        const SizedBox(height: 30),

        _description(p),
      ],
    );
  }

  // ------------------------------------------------------
  // الألوان
  // ------------------------------------------------------

  Widget _colorSelector(Map p) {
    final colors = p["colors"] ?? [];

    if (colors.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Color",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        Row(
          children: colors.map<Widget>((c) {
            final cStr = c.toString();
            final bool active = selectedColor == cStr;

            // يدعم تخزين اللون كـ int أو string
            Color colorValue;
            if (c is int) {
              colorValue = Color(c);
            } else {
              // مثلاً "0xFF123456"
              colorValue = Color(int.tryParse(cStr) ?? 0xFF000000);
            }

            return GestureDetector(
              onTap: () => setState(() => selectedColor = cStr),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: active ? Colors.blue : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(backgroundColor: colorValue, radius: 12),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ------------------------------------------------------
  // الإضافات (Addons)
  // ------------------------------------------------------

  Widget _addonsSection(Map p) {
    final addons = p["addons"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Add-ons",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        ...addons.map<Widget>((addon) {
          bool selected = addon["selected"] == true;

          return CheckboxListTile(
            title: Text("${addon['name']} (+${addon['extraPrice']} \$)"),
            value: selected,
            onChanged: (v) {
              setState(() {
                addon["selected"] = v == true;
                _updatePrice();
              });
            },
          );
        }).toList(),
      ],
    );
  }

  // ------------------------------------------------------
  // الخيارات (Choices)
  // ------------------------------------------------------

  Widget _choicesSection(Map p) {
    final choices = p["choices"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Options",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        ...choices.map<Widget>((group) {
          final items = group["items"] ?? [];
          final selected = group["selected"];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group["groupName"] ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              ...items.map<Widget>((item) {
                bool active =
                    selected != null && selected["name"] == item["name"];

                return RadioListTile(
                  title: Text("${item['name']} (+${item['extraPrice']}\$)"),
                  value: item,
                  groupValue: selected,
                  onChanged: (v) {
                    setState(() {
                      group["selected"] = v;
                      _updatePrice();
                    });
                  },
                );
              }).toList(),

              const SizedBox(height: 15),
            ],
          );
        }).toList(),
      ],
    );
  }

  // ------------------------------------------------------
  // الكمية + إضافة للسلة
  // ------------------------------------------------------

  Widget _qtyAddButton(Map p) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => setState(() {
                if (quantity > 1) quantity--;
              }),
              icon: const Icon(Icons.remove_circle_outline),
            ),

            Text("$quantity", style: const TextStyle(fontSize: 20)),

            IconButton(
              onPressed: () => setState(() => quantity++),
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),

        const SizedBox(width: 20),

        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Added to Cart")));
            },
            child: const Text(
              "Add to Cart",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------
  // الوصف
  // ------------------------------------------------------

  Widget _description(Map p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          p["description"] ?? "",
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ],
    );
  }
}
