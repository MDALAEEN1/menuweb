import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/generated/l10n.dart';
import 'package:menuweb/main.dart';

/// =====================================================
/// MAIN NAV BAR (Responsive Wrapper)
/// =====================================================
class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w < 768 ? const _MobileNavBar() : const _DesktopNavBar();
  }
}

/// =====================================================
/// MOBILE NAV BAR
/// =====================================================
class _MobileNavBar extends StatelessWidget {
  const _MobileNavBar();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          /// LOGO
          InkWell(
            onTap: () => Navigator.pushNamed(context, "/"),
            child: Text(
              "Suda",
              style: TextStyle(
                color: c.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Spacer(),

          /// LANGUAGE
          IconButton(
            icon: Icon(Icons.language, color: c.textPrimary),
            onPressed: () => _openLanguageBottomSheet(
              context,
              S.delegate.supportedLocales,
              MenuApp.of(context).locale,
            ),
          ),

          /// THEME
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: c.textPrimary,
            ),
            onPressed: () => MenuApp.of(context).toggleTheme(),
          ),

          /// MENU
          IconButton(
            icon: Icon(Icons.menu_rounded, color: c.textPrimary),
            onPressed: () => _openMobileMenu(context),
          ),
        ],
      ),
    );
  }
}

/// =====================================================
/// DESKTOP NAV BAR
/// =====================================================
class _DesktopNavBar extends StatelessWidget {
  const _DesktopNavBar();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 18),
      child: Row(
        children: [
          /// LOGO
          InkWell(
            onTap: () => Navigator.pushNamed(context, "/"),
            child: Text(
              "Suda System",
              style: TextStyle(
                color: c.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Spacer(),
          _NavItem(title: "Home", route: "/Home"),
          _NavItem(title: "Features", route: "/whyus"),
          _NavItem(title: "Business Types", route: "/BusinessType"),
          _NavItem(title: "Download", route: "/Download"),
          _NavItem(title: "How it works", route: "/HowWorks"),

          const SizedBox(width: 16),

          _LanguageSelector(isMobile: false),

          const SizedBox(width: 8),

          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: c.textPrimary,
            ),
            onPressed: () => MenuApp.of(context).toggleTheme(),
          ),

          const SizedBox(width: 12),

          PrimaryButton(
            title: "Start Now",
            onTap: () => Navigator.pushNamed(context, "/Download"),
          ),
        ],
      ),
    );
  }
}

/// =====================================================
/// MOBILE MENU (Bottom Sheet)
/// =====================================================
void _openMobileMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MobileNavItem("Home", "/Home"),
            _MobileNavItem("Features", "/whyus"),
            _MobileNavItem("Download", "/Download"),
            _MobileNavItem("How it works", "/HowWorks"),
            _MobileNavItem("Business Types", "/BusinessType"),
            const SizedBox(height: 16),
            PrimaryButton(
              title: "Start Now",
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/Menu");
              },
            ),
          ],
        ),
      );
    },
  );
}

class _MobileNavItem extends StatelessWidget {
  final String title;
  final String route;
  const _MobileNavItem(this.title, this.route);

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: c.textPrimary, fontWeight: FontWeight.w600),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}

/// =====================================================
/// NAV ITEM (DESKTOP)
/// =====================================================
class _NavItem extends StatelessWidget {
  final String title;
  final String route;
  const _NavItem({required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.pushNamed(context, route),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          title,
          style: TextStyle(color: c.textSecondary, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

/// =====================================================
/// PRIMARY BUTTON
/// =====================================================
class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const PrimaryButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: BoxDecoration(
          color: c.primary,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Text(
          title,
          style: TextStyle(color: c.onPrimary, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// =====================================================
/// LANGUAGE SELECTOR
/// =====================================================
class _LanguageSelector extends StatelessWidget {
  final bool isMobile;
  const _LanguageSelector({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final supported = S.delegate.supportedLocales;
    final current = MenuApp.of(context).locale;

    if (isMobile) {
      return IconButton(
        icon: Icon(Icons.language, color: c.textPrimary),
        onPressed: () => _openLanguageBottomSheet(context, supported, current),
      );
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<Locale>(
        value: current,
        icon: Icon(Icons.language, color: c.textPrimary),
        dropdownColor: c.surface,
        items: supported.map((locale) {
          return DropdownMenuItem(
            value: locale,
            child: Text(
              _langName(locale.languageCode),
              style: TextStyle(color: c.textPrimary),
            ),
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
}

/// =====================================================
/// LANGUAGE BOTTOM SHEET
/// =====================================================
void _openLanguageBottomSheet(
  BuildContext context,
  List<Locale> supported,
  Locale current,
) {
  showModalBottomSheet(
    context: context,
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
              title: Text(_langName(locale.languageCode)),
              trailing: locale == current
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                MenuApp.of(context).setLocale(locale);
                Navigator.pop(context);
              },
            );
          }),
          const SizedBox(height: 12),
        ],
      );
    },
  );
}

/// =====================================================
/// HELPERS
/// =====================================================
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
