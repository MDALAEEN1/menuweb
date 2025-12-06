import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/MenuPage/product_details_page/product_details_page.dart';
import 'package:menuweb/generated/l10n.dart';
import 'package:menuweb/main.dart';

PreferredSizeWidget customWebAppBar(BuildContext context) {
  final colors = Theme.of(context).extension<AppColors>()!;
  final width = MediaQuery.of(context).size.width;

  bool isMobile = width < 650;
  bool isTablet = width >= 650 && width < 1000;

  final uid = Hive.box("menu_cache").get("uid");
  final storeName = Hive.box("menu_cache").get("storeName_$uid") ?? "";
  return AppBar(
    scrolledUnderElevation: 0,
    backgroundColor: colors.card, // ثيم
    elevation: 0,
    toolbarHeight: 70,
    automaticallyImplyLeading: false,
    titleSpacing: 0,

    title: Row(
      children: [
        const SizedBox(width: 20),

        // Logo
        Text(
          storeName.isEmpty ? "Store" : storeName,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),

        const Spacer(),

        // ============================
        // DESKTOP (روابط + بحث)
        // ============================
        if (!isMobile && !isTablet) ...[
          _navButton(S.of(context).menu, "/Menu", context, colors),
          // _navButton(S.of(context).whyUs, "/whyus", context, colors),
          const SizedBox(width: 20),
          ProductSearchBox(uid: uid),
          const SizedBox(width: 20),
        ],

        // ============================
        // TABLET (روابط + ايقونة بحث)
        // ============================
        if (isTablet) ...[
          _navButton(S.of(context).menu, "/Menu", context, colors),
          //_navButton(S.of(context).whyUs, "/whyus", context, colors),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.search, color: colors.textPrimary),
            onPressed: () => _openSearchOverlay(context, uid),
          ),
          const SizedBox(width: 10),
        ],

        // ============================
        // Mobile Search Icon
        // ============================
        if (isMobile) const SizedBox(width: 10),

        // Language dropdown / mobile icon
        _languageSelector(context, colors),
        const SizedBox(width: 10),

        // Theme switch
        IconButton(
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode,
            color: colors.textPrimary,
          ),
          onPressed: () => MenuApp.of(context).toggleTheme(),
        ),

        const SizedBox(width: 10),

        // Cart only on desktop/tablet
        if (!isMobile)
          _iconButton(Icons.shopping_cart_outlined, colors, () {
            Navigator.pushNamed(context, "/cart");
          }),

        const SizedBox(width: 10),

        // Mobile hamburger menu
        if (isMobile)
          IconButton(
            icon: Icon(Icons.menu, color: colors.textPrimary),
            onPressed: () => _openMobileMenu(context),
          ),

        const SizedBox(width: 10),
      ],
    ),
  );
}

Widget _navButton(
  String title,
  String route,
  BuildContext context,
  AppColors colors,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: colors.textPrimary, // ثيم
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

// -------- Search Box --------
class ProductSearchBox extends StatefulWidget {
  final String uid;
  const ProductSearchBox({super.key, required this.uid});

  @override
  State<ProductSearchBox> createState() => _ProductSearchBoxState();
}

class _ProductSearchBoxState extends State<ProductSearchBox> {
  final TextEditingController controller = TextEditingController();
  OverlayEntry? overlayEntry;
  List<Map<String, dynamic>> results = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_onSearchChanged);
    controller.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = controller.text.trim();
    if (query.isEmpty) {
      results.clear();
      _removeOverlay();
      return;
    }
    _searchFirestore(query);
  }

  Future<void> _searchFirestore(String query) async {
    setState(() => loading = true);

    final snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .collection("products")
        .where("name", isGreaterThanOrEqualTo: query)
        .where("name", isLessThanOrEqualTo: "$query\uf8ff")
        .limit(10)
        .get();

    results = snap.docs.map((d) => d.data()).toList();

    setState(() => loading = false);

    if (results.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    _removeOverlay();

    final overlay = Overlay.of(context);
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final position = box.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (_) {
        return Positioned(
          left: position.dx,
          top: position.dy + box.size.height + 6,
          width: box.size.width,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: results.map((p) {
                  return ListTile(
                    title: Text(p['name'] ?? ''),
                    onTap: () {
                      _removeOverlay();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsUI(product: p),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry!);
  }

  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Container(
      width: 230,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: colors.card.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.textSecondary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 20, color: colors.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: S.of(context).searchHint,
                hintStyle: TextStyle(
                  color: colors.textSecondary.withOpacity(0.8),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------- Icon Button --------
Widget _iconButton(IconData icon, AppColors colors, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.background.withOpacity(0.08), // ثيم
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 22, color: colors.textPrimary),
    ),
  );
}

// -------- Mobile Drawer Menu --------
void _openMobileMenu(BuildContext context) {
  final colors = Theme.of(context).extension<AppColors>()!;
  final uid = Hive.box("menu_cache").get("uid");

  showModalBottomSheet(
    context: context,
    backgroundColor: colors.card,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),

          _mobileItem(context, S.of(context).menu, "/Menu", colors),
          // _mobileItem(context, S.of(context).whyUs, "/whyus", colors),

          // 🛒 Cart inside mobile menu
          _mobileItem(context, S.of(context).cart, "/cart", colors),

          // 🔍 Search inside menu (beautiful line item)
          ListTile(
            leading: Icon(Icons.search, color: colors.textPrimary),
            title: Text(
              S.of(context).search,
              style: TextStyle(color: colors.textPrimary),
            ),
            onTap: () {
              Navigator.pop(context);
              _openSearchOverlay(context, uid);
            },
          ),

          const SizedBox(height: 20),
        ],
      );
    },
  );
}

Widget _mobileItem(
  BuildContext context,
  String title,
  String route,
  AppColors colors,
) {
  return ListTile(
    leading: Icon(Icons.arrow_right, color: colors.textPrimary),
    title: Text(
      title,
      style: TextStyle(color: colors.textPrimary, fontSize: 18),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, route);
    },
  );
}

Widget _languageSelector(BuildContext context, AppColors colors) {
  final width = MediaQuery.of(context).size.width;
  bool isMobile = width < 650;

  final supported = S.delegate.supportedLocales;
  final current = Localizations.localeOf(context);

  // ============================
  // MOBILE: Icon only (no text)
  // ============================
  if (isMobile) {
    return IconButton(
      icon: Icon(Icons.language, color: colors.textPrimary),
      onPressed: () {
        _openLanguageBottomSheet(context, supported, current);
      },
    );
  }

  // ============================
  // DESKTOP / TABLET: Dropdown
  // ============================
  return DropdownButtonHideUnderline(
    child: DropdownButton<Locale>(
      value: current,
      icon: Icon(Icons.language, color: colors.textPrimary),
      items: supported.map((locale) {
        return DropdownMenuItem(
          value: locale,
          child: Text(_langName(locale.languageCode)),
        );
      }).toList(),
      onChanged: (locale) {
        if (locale != null) {
          MenuApp.of(context).setLocale(locale);
        }
      },
    ),
  );
}

String _langName(String code) {
  switch (code) {
    case 'ar':
      return "العربية";
    case 'en':
      return "English";
    case 'tr':
      return "Türkçe";

    default:
      return code.toUpperCase();
  }
}

void _openSearchOverlay(BuildContext context, String uid) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(height: 60, child: ProductSearchBox(uid: uid)),
    ),
  );
}

void _openLanguageBottomSheet(
  BuildContext context,
  List<Locale> supported,
  Locale current,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Text(
            "Select Language",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          ...supported.map((locale) {
            return ListTile(
              title: Text(
                _langName(locale.languageCode),
                style: const TextStyle(fontSize: 17),
              ),
              trailing: locale == current
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                MenuApp.of(context).setLocale(locale);
                Navigator.pop(context);
              },
            );
          }),

          const SizedBox(height: 10),
        ],
      );
    },
  );
}

Widget _mobileLanguageSelector(BuildContext context, AppColors colors) {
  final supported = S.delegate.supportedLocales;
  final current = Localizations.localeOf(context);

  return Column(
    children: supported.map((locale) {
      return ListTile(
        leading: Icon(Icons.language, color: colors.textPrimary),
        title: Text(
          _langName(locale.languageCode),
          style: TextStyle(color: colors.textPrimary),
        ),
        trailing: locale == current
            ? Icon(Icons.check, color: colors.primary)
            : null,
        onTap: () {
          MenuApp.of(context).setLocale(locale);
          Navigator.pop(context);
        },
      );
    }).toList(),
  );
}
