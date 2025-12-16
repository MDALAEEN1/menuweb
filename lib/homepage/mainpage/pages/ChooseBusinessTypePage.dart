import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/homepage/mainpage/assets/NavBar.dart';

class ChooseBusinessTypePage extends StatelessWidget {
  const ChooseBusinessTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: c.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            _Hero(),
            _CategoryCards(),
            _WhyChoose(),
            _Footer(),
          ],
        ),
      ),
    );
  }
}

/* ======================= HERO ======================= */

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 64,
            vertical: isMobile ? 40 : 72,
          ),
          child: Column(
            children: [
              Text(
                "Choose your business type",
                textAlign: isMobile ? TextAlign.center : TextAlign.center,
                style: TextStyle(
                  color: c.textPrimary,
                  fontSize: isMobile ? 32 : 42,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Select the category that best fits your operations to customize your Suda experience.\n"
                "We'll optimize your dashboard with the tools you need.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: c.textSecondary,
                  fontSize: isMobile ? 14 : 16,
                  height: 1.6,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/* ======================= CATEGORY CARDS ======================= */

class _CategoryCards extends StatelessWidget {
  const _CategoryCards();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        final isTablet = constraints.maxWidth < 1024;

        if (isMobile) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _CategoryCard.retail(),
                const SizedBox(height: 16),
                _CategoryCard.restaurant(),
                const SizedBox(height: 16),
                _CategoryCard.home(),
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 64),
          child: Row(
            children: [
              Expanded(child: _CategoryCard.retail()),
              SizedBox(width: isTablet ? 16 : 24),
              Expanded(child: _CategoryCard.restaurant()),
              SizedBox(width: isTablet ? 16 : 24),
              Expanded(child: _CategoryCard.home()),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> items;
  final bool highlight;
  final String buttonText;
  final String routeName;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.buttonText,
    required this.routeName,
    this.highlight = false,
  });

  factory _CategoryCard.retail() => const _CategoryCard(
    title: "Retail Stores",
    subtitle: "Perfect for clothing, accessories, minimarkets, home goods.",
    items: [
      "Full inventory management",
      "Point of Sale (POS)",
      "Integrated online store",
      "Accounting tools",
      "Sales analytics",
      "Up to 5 staff members",
    ],
    buttonText: "Select Retail",
    routeName: "/setup/retail",
  );

  factory _CategoryCard.restaurant() => const _CategoryCard(
    title: "Restaurants & Cafés",
    subtitle: "Tailored for food service operations and hospitality.",
    items: [
      "POS with table management",
      "Kitchen printing support",
      "Online ordering page",
      "Delivery driver system",
      "Staff management with GPS",
      "Daily financial reports",
    ],
    buttonText: "Select Restaurant",
    routeName: "/setup/restaurant",
    highlight: true,
  );

  factory _CategoryCard.home() => const _CategoryCard(
    title: "Home-Based",
    subtitle: "Simple tools for small sellers, creators, and freelancers.",
    items: [
      "Online store builder",
      "Basic POS",
      "Customer records (CRM)",
      "Daily analytics",
      "Limited products",
      "1 staff account",
    ],
    buttonText: "Select Home-Based",
    routeName: "/setup/home",
  );

  Future<void> _handleNavigation(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Simulate loading time
    await Future.delayed(const Duration(milliseconds: 500));

    if (context.mounted) {
      Navigator.of(context).pop(); // Remove loading
      Navigator.pushNamed(context, routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleNavigation(context),
        child: MergeSemantics(
          child: Semantics(
            button: true,
            label: title,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: highlight ? c.primary : c.border,
                  width: highlight ? 1.5 : 1,
                ),
                boxShadow: highlight
                    ? [
                        BoxShadow(
                          color: c.primary.withOpacity(0.12),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (highlight)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: c.border,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Popular Choice",
                          style: TextStyle(
                            color: c.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Semantics(
                    header: true,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: c.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(subtitle, style: TextStyle(color: c.textSecondary)),
                  const SizedBox(height: 18),
                  Text(
                    "INCLUDES",
                    style: TextStyle(
                      color: c.textSecondary,
                      fontSize: 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// ✅ قائمة الميزات
                  ...items.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle, color: c.primary, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              e,
                              style: TextStyle(
                                color: c.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// ✅ الأزرار
                  highlight
                      ? _PrimaryBtn(
                          buttonText,
                          full: true,
                          onTap: () => _handleNavigation(context),
                        )
                      : _GhostBtn(
                          buttonText,
                          full: true,
                          onTap: () => _handleNavigation(context),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* ======================= WHY CHOOSE ======================= */

class _WhyChoose extends StatelessWidget {
  const _WhyChoose();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        final isTablet = constraints.maxWidth < 1024;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile
                ? 24
                : isTablet
                ? 32
                : 64,
            vertical: isMobile ? 40 : 72,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Why choose Suda?",
                style: TextStyle(
                  color: c.textPrimary,
                  fontSize: isMobile ? 24 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Designed to streamline your operations, no matter your industry size.",
                style: TextStyle(color: c.textSecondary),
              ),
              const SizedBox(height: 28),

              if (isMobile)
                Column(
                  children: const [
                    _WhyCard(
                      Icons.dashboard,
                      "Unified Dashboard",
                      "Manage everything from one place.",
                    ),
                    SizedBox(height: 16),
                    _WhyCard(
                      Icons.trending_up,
                      "Real-time Analytics",
                      "Track growth instantly with live charts.",
                    ),
                    SizedBox(height: 16),
                    _WhyCard(
                      Icons.support_agent,
                      "24/7 Support",
                      "Dedicated support when you need it.",
                    ),
                  ],
                )
              else
                Row(
                  children: const [
                    Expanded(
                      child: _WhyCard(
                        Icons.dashboard,
                        "Unified Dashboard",
                        "Manage everything from one place.",
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: _WhyCard(
                        Icons.trending_up,
                        "Real-time Analytics",
                        "Track growth instantly with live charts.",
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: _WhyCard(
                        Icons.support_agent,
                        "24/7 Support",
                        "Dedicated support when you need it.",
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class _WhyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _WhyCard(this.icon, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: c.border,
            child: Icon(icon, color: c.primary),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(color: c.textPrimary, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(desc, style: TextStyle(color: c.textSecondary)),
        ],
      ),
    );
  }
}

/* ======================= FOOTER ======================= */

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          Divider(color: c.border),
          SizedBox(height: 24),
          Text(
            "© 2025 Suda Systems. All rights reserved.",
            style: TextStyle(color: c.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

/* ======================= BUTTONS ======================= */

class _PrimaryBtn extends StatelessWidget {
  final String text;
  final bool full;
  final VoidCallback? onTap;

  const _PrimaryBtn(this.text, {this.full = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return Semantics(
      button: true,
      label: text,
      child: SizedBox(
        width: full ? double.infinity : null,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                color: c.primary,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: c.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GhostBtn extends StatelessWidget {
  final String text;
  final bool full;
  final VoidCallback? onTap;

  const _GhostBtn(this.text, {this.full = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return Semantics(
      button: true,
      label: text,
      child: SizedBox(
        width: full ? double.infinity : null,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: c.border),
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: c.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
