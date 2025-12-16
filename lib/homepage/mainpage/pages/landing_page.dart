import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/homepage/mainpage/assets/NavBar.dart';
import 'package:menuweb/homepage/mainpage/assets/responsive.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: c.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(),
            HeroSection(),
            WhySudaSection(),
            SystemSection(),
            FeaturesGridSection(),
            BusinessTypesSection(),
            CTASection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final pad = R.pagePad(w);
        final isMobile = R.isMobile(w);

        return Container(
          constraints: BoxConstraints(minHeight: isMobile ? 560 : 620),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [c.primaryGlow.withOpacity(0.35), c.background],
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: pad, vertical: 40),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HeroText(c, w),
                          SizedBox(height: R.gap(w)),
                          _HeroPreview(c),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(flex: 6, child: _HeroText(c, w)),
                          SizedBox(width: R.gap(w)),
                          Expanded(flex: 5, child: _HeroPreview(c)),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeroText extends StatelessWidget {
  final AppColors c;
  final double w;
  const _HeroText(this.c, this.w);

  @override
  Widget build(BuildContext context) {
    final isMobile = R.isMobile(w);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Suda — Manage Your\nBusiness the Easy Way",
          style: TextStyle(
            color: c.textPrimary,
            fontSize: R.heroTitle(w),
            height: 1.15,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Streamline operations, boost sales, and regain control "
          "with the all-in-one platform built for modern entrepreneurs.",
          style: TextStyle(
            color: c.textSecondary,
            fontSize: isMobile ? 15.5 : 17,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 24),
        isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryButton(
                    "Start Now",
                    onTap: () {
                      Navigator.pushNamed(context, "/Download");
                    },
                  ),
                  const SizedBox(height: 12),
                  OutlineButtonCustom(
                    "See How Suda Works",
                    onTap: () {
                      Navigator.pushNamed(context, "/HowWorks");
                    },
                  ),
                ],
              )
            : Row(
                children: [
                  PrimaryButton(
                    "Start Now",
                    onTap: () {
                      Navigator.pushNamed(context, "/Download");
                    },
                  ),
                  const SizedBox(width: 16),
                  OutlineButtonCustom(
                    "See How Suda Works",
                    onTap: () {
                      Navigator.pushNamed(context, "/HowWorks");
                    },
                  ),
                ],
              ),
      ],
    );
  }
}

class _HeroPreview extends StatelessWidget {
  final AppColors c;
  const _HeroPreview(this.c);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        color: c.surfaceSoft,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: c.border),
      ),
      child: const Center(
        child: Text("Dashboard Preview", style: TextStyle(fontSize: 14)),
      ),
    );
  }
}

class FeaturesGridSection extends StatelessWidget {
  const FeaturesGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: R.pagePad(w),
        vertical: R.isMobile(w) ? 56 : 90,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// =======================
          /// TITLE
          /// =======================
          Text(
            "Top Features Preview",
            style: TextStyle(
              color: c.textPrimary,
              fontSize: R.heroTitle(w) - 8, // أصغر شوي من الهيرو
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: R.gap(w) / 2),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              "Everything you need to grow, built into one cohesive ecosystem.",
              style: TextStyle(
                color: c.textSecondary.withOpacity(0.9),
                fontSize: R.isMobile(w) ? 14.5 : 15.5,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: R.isMobile(w) ? 32 : 48),

          /// =======================
          /// GRID
          /// =======================
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: GridView.count(
                crossAxisCount: R.gridCols(w),
                crossAxisSpacing: R.gap(w) * 1.4,
                mainAxisSpacing: R.gap(w) * 1.4,
                childAspectRatio: R.isMobile(w)
                    ? 1.1
                    : R.isTablet(w)
                    ? 1.25
                    : 1.4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  FeatureCard(
                    icon: Icons.point_of_sale_rounded,
                    title: "POS System",
                    desc:
                        "Accept payments anywhere with our versatile Mobile & "
                        "Desktop POS. Offline mode included.",
                    previewType: FeaturePreviewType.pos,
                  ),
                  FeatureCard(
                    icon: Icons.inventory_2_rounded,
                    title: "Inventory Management",
                    desc:
                        "Real-time stock tracking with low-stock alerts and "
                        "automatic reordering suggestions.",
                    previewType: FeaturePreviewType.inventory,
                  ),
                  FeatureCard(
                    icon: Icons.storefront_rounded,
                    title: "Online Store",
                    desc:
                        "Launch a professional e-commerce site that syncs "
                        "perfectly with your physical inventory.",
                    previewType: FeaturePreviewType.store,
                  ),
                  FeatureCard(
                    icon: Icons.receipt_long_rounded,
                    title: "Daily Accounting",
                    desc:
                        "Automated bookkeeping, expense tracking, and "
                        "profit/loss reports at your fingertips.",
                    previewType: FeaturePreviewType.accounting,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum FeaturePreviewType { pos, inventory, store, accounting }

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final FeaturePreviewType previewType;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
    required this.previewType,
  });

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: c.surfaceSoft,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: c.border.withOpacity(0.35)),
        boxShadow: [
          BoxShadow(
            color: c.border,
            blurRadius: 40,
            offset: const Offset(0, 22),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// =======================
          /// HEADER
          /// =======================
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: c.primary.withOpacity(0.18),
                ),
                child: Icon(icon, color: c.primary, size: 20),
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: TextStyle(
                  color: c.textPrimary,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          /// DESCRIPTION
          Text(
            desc,
            style: TextStyle(
              color: c.textSecondary.withOpacity(0.85),
              fontSize: 14.2,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 22),

          /// =======================
          /// PREVIEW AREA
          /// =======================
          Expanded(child: FeaturePreview(type: previewType)),
        ],
      ),
    );
  }
}

class FeaturePreview extends StatelessWidget {
  final FeaturePreviewType type;

  const FeaturePreview({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: c.border.withOpacity(0.25)),
      ),
      padding: const EdgeInsets.all(16),
      child: _buildPreview(c),
    );
  }

  Widget _buildPreview(AppColors c) {
    switch (type) {
      case FeaturePreviewType.pos:
        return Row(
          children: List.generate(
            3,
            (i) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: i == 0 ? c.primary.withOpacity(0.35) : c.surfaceSoft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        );

      case FeaturePreviewType.inventory:
        return Column(
          children: List.generate(
            4,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: c.surfaceSoft,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 18,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i.isEven ? c.primary.withOpacity(0.7) : c.border,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

      case FeaturePreviewType.store:
        return Row(
          children: List.generate(
            2,
            (i) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: c.surfaceSoft,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
        );

      case FeaturePreviewType.accounting:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(
            4,
            (i) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  height: 20.0 + (i * 16),
                  decoration: BoxDecoration(
                    color: i == 3 ? c.primary.withOpacity(0.6) : c.surfaceSoft,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }
}

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final w = MediaQuery.of(context).size.width;
    final isMobile = R.isMobile(w);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 72 : 110,
        horizontal: R.pagePad(w),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Container(
            decoration: BoxDecoration(
              color: c.card,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: c.border.withOpacity(0.35)),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 61,
              vertical: isMobile ? 36 : 54,
            ),
            child: Column(
              children: [
                /// TITLE
                Text(
                  "Ready to take control?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: c.textPrimary,
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: 16),

                /// SUBTITLE
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Text(
                    "Join thousands of entrepreneurs who trust Suda to power their daily operations.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: c.textSecondary.withOpacity(0.9),
                      fontSize: isMobile ? 14.5 : 15.5,
                      height: 1.6,
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 28 : 36),

                /// BUTTONS
                isMobile ? _CTAButtonsColumn(c) : _CTAButtonsRow(c),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CTAButtonsRow extends StatelessWidget {
  final AppColors c;
  const _CTAButtonsRow(this.c);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_PrimaryCTA(c), const SizedBox(width: 18), _SecondaryCTA(c)],
    );
  }
}

class _CTAButtonsColumn extends StatelessWidget {
  final AppColors c;
  const _CTAButtonsColumn(this.c);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PrimaryCTA(c, fullWidth: true),
        const SizedBox(height: 14),
        _SecondaryCTA(c, fullWidth: true),
      ],
    );
  }
}

class _PrimaryCTA extends StatelessWidget {
  final AppColors c;
  final bool fullWidth;

  const _PrimaryCTA(this.c, {this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
      decoration: BoxDecoration(
        color: c.primary,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: c.primary.withOpacity(0.45),
            blurRadius: 26,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Text(
        "Start for Free",
        style: TextStyle(
          color: c.onPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
    );
  }
}

class _SecondaryCTA extends StatelessWidget {
  final AppColors c;
  final bool fullWidth;

  const _SecondaryCTA(this.c, {this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: c.border.withOpacity(0.5)),
        color: c.surfaceSoft.withOpacity(0.4),
      ),
      child: Text(
        "Contact Sales",
        style: TextStyle(
          color: c.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }
}

class WhySudaSection extends StatelessWidget {
  const WhySudaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final w = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: R.isMobile(w) ? 72 : 110,
        horizontal: R.pagePad(w),
      ),
      decoration: BoxDecoration(color: c.background),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              /// SECTION LABEL
              Text(
                "WHY SUDA?",
                style: TextStyle(
                  color: c.primary,
                  fontSize: R.isMobile(w) ? 12 : 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
              SizedBox(height: R.gap(w)),

              /// SECTION TITLE
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  "Experience the power of simplicity",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: c.textPrimary,
                    fontSize: R.isMobile(w)
                        ? 28
                        : R.isTablet(w)
                        ? 32
                        : 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    height: 1.25,
                  ),
                ),
              ),
              SizedBox(height: R.isMobile(w) ? 40 : 64),

              /// CARDS (Column on mobile, Row otherwise)
              _WhySudaCards(w),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhySudaCards extends StatelessWidget {
  final double w;
  const _WhySudaCards(this.w);

  @override
  Widget build(BuildContext context) {
    if (R.isMobile(w)) {
      return Column(
        children: const [
          InfoCard(
            icon: Icons.layers_rounded,
            title: "All your tools in one place",
            desc:
                "Integrate everything you need into a single dashboard. "
                "No more switching between multiple disjointed apps.",
          ),
          SizedBox(height: 20),
          InfoCard(
            icon: Icons.storefront_rounded,
            title: "Built for business owners",
            desc:
                "Designed with the entrepreneur's journey in mind, "
                "cutting out the jargon and focusing on growth.",
          ),
          SizedBox(height: 20),
          InfoCard(
            icon: Icons.flash_on_rounded,
            title: "Fast and easy to use",
            desc:
                "Get up and running in minutes, not days. "
                "Intuitive interfaces mean less training time for your staff.",
          ),
        ],
      );
    }

    return Row(
      children: const [
        Expanded(
          child: InfoCard(
            icon: Icons.layers_rounded,
            title: "All your tools in one place",
            desc:
                "Integrate everything you need into a single dashboard. "
                "No more switching between multiple disjointed apps.",
          ),
        ),
        SizedBox(width: 28),
        Expanded(
          child: InfoCard(
            icon: Icons.storefront_rounded,
            title: "Built for business owners",
            desc:
                "Designed with the entrepreneur's journey in mind, "
                "cutting out the jargon and focusing on growth.",
          ),
        ),
        SizedBox(width: 28),
        Expanded(
          child: InfoCard(
            icon: Icons.flash_on_rounded,
            title: "Fast and easy to use",
            desc:
                "Get up and running in minutes, not days. "
                "Intuitive interfaces mean less training time for your staff.",
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(R.isMobile(w) ? 24 : 32),
      decoration: BoxDecoration(
        color: c.surfaceSoft,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: c.border.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: c.border.withOpacity(0.6),
            blurRadius: R.isMobile(w) ? 24 : 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON
          Container(
            width: R.isMobile(w) ? 42 : 46,
            height: R.isMobile(w) ? 42 : 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: c.primary.withOpacity(0.18),
            ),
            child: Icon(icon, color: c.primary, size: R.isMobile(w) ? 20 : 22),
          ),
          SizedBox(height: R.isMobile(w) ? 20 : 24),

          /// TITLE
          Text(
            title,
            style: TextStyle(
              color: c.textPrimary,
              fontSize: R.isMobile(w) ? 16.5 : 18,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),

          /// DESCRIPTION
          Text(
            desc,
            style: TextStyle(
              color: c.textSecondary.withOpacity(0.85),
              fontSize: R.isMobile(w) ? 14 : 14.5,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const PrimaryButton(this.title, {super.key, required this.onTap});

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
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class OutlineButtonCustom extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const OutlineButtonCustom(this.title, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: c.border),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Text(
          title,
          style: TextStyle(color: c.textPrimary, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer();

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

class SystemSection extends StatelessWidget {
  const SystemSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final w = MediaQuery.of(context).size.width;
    final isMobile = R.isMobile(w);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: R.pagePad(w),
        vertical: isMobile ? 56 : 80,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 48,
          vertical: isMobile ? 28 : 40,
        ),
        decoration: BoxDecoration(
          color: c.surfaceSoft,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: c.border.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: c.border.withOpacity(0.6),
              blurRadius: isMobile ? 28 : 50,
              offset: const Offset(0, 24),
            ),
          ],
        ),
        child: isMobile ? _SystemMobileLayout(c) : _SystemDesktopLayout(c),
      ),
    );
  }
}

class _SystemMobileLayout extends StatelessWidget {
  final AppColors c;
  const _SystemMobileLayout(this.c);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DashboardPreview(c, height: 200),
        const SizedBox(height: 28),
        _SystemText(c, isMobile: true),
      ],
    );
  }
}

class _SystemDesktopLayout extends StatelessWidget {
  final AppColors c;
  const _SystemDesktopLayout(this.c);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _SystemText(c)),
        const SizedBox(width: 48),
        Expanded(flex: 5, child: _DashboardPreview(c)),
      ],
    );
  }
}

class _SystemText extends StatelessWidget {
  final AppColors c;
  final bool isMobile;

  const _SystemText(this.c, {this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "One system that runs\nyour entire business",
          style: TextStyle(
            color: c.textPrimary,
            fontSize: isMobile ? 26 : 34,
            height: 1.2,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "From sales to inventory, manage every aspect of your "
          "operations seamlessly. Suda brings clarity to your chaos "
          "with real-time analytics and centralized control.",
          style: TextStyle(
            color: c.textSecondary.withOpacity(0.9),
            fontSize: isMobile ? 14.5 : 15.5,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 28),
        Row(
          children: const [
            _StatItem(value: "10k+", label: "Active Users"),
            SizedBox(width: 32),
            _StatItem(value: "99.9%", label: "Uptime"),
          ],
        ),
      ],
    );
  }
}

class _DashboardPreview extends StatelessWidget {
  final AppColors c;
  final double height;

  const _DashboardPreview(this.c, {this.height = 260});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.asset(
            "assets/system_dashboard.png",
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: height,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                ),
                child: Text(
                  "Dashboard preview will appear here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
              );
            },
          ),

          /// Overlay
          Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  c.background.withOpacity(0.05),
                  c.background.withOpacity(0.45),
                ],
              ),
            ),
          ),

          /// Live badge
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: c.border.withOpacity(0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: c.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Live Dashboard Sync",
                    style: TextStyle(
                      color: c.textPrimary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: c.textPrimary,
            fontSize: R.isMobile(w) ? 22 : 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: c.textSecondary.withOpacity(0.85),
            fontSize: R.isMobile(w) ? 12.5 : 13.5,
          ),
        ),
      ],
    );
  }
}

class BusinessTypesSection extends StatelessWidget {
  const BusinessTypesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final w = MediaQuery.of(context).size.width;
    final isMobile = R.isMobile(w);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: R.pagePad(w),
        vertical: isMobile ? 72 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// TITLE
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Text(
              "Designed for Three Business Types",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: c.textPrimary,
                fontSize: isMobile ? 28 : 34,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              "Tailored workflows to meet the unique demands of your industry.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: c.textSecondary.withOpacity(0.9),
                fontSize: isMobile ? 14.5 : 15.5,
                height: 1.6,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 40 : 64),

          /// CARDS
          _BusinessCardsLayout(w),
        ],
      ),
    );
  }
}

class _BusinessCardsLayout extends StatelessWidget {
  final double w;
  const _BusinessCardsLayout(this.w);

  @override
  Widget build(BuildContext context) {
    if (R.isMobile(w)) {
      return Column(
        children: const [
          BusinessTypeCard(
            title: "Retail Stores",
            description:
                "Manage SKUs, variants, and multi-location stock with ease.",
            imagePath: "assets/business_retail.jpg",
            icon: Icons.shopping_bag_rounded,
          ),
          SizedBox(height: 20),
          BusinessTypeCard(
            title: "Restaurants & Cafés",
            description:
                "Table management, kitchen display systems, and ingredient tracking.",
            imagePath: "assets/business_restaurant.jpg",
            icon: Icons.restaurant_rounded,
          ),
          SizedBox(height: 20),
          BusinessTypeCard(
            title: "Home-Based",
            description:
                "Lightweight tools for side hustles, freelancers, and crafters.",
            imagePath: "assets/business_home.jpg",
            icon: Icons.home_work_rounded,
          ),
        ],
      );
    }

    if (R.isTablet(w)) {
      return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          BusinessTypeCard(
            title: "Retail Stores",
            description:
                "Manage SKUs, variants, and multi-location stock with ease.",
            imagePath: "assets/business_retail.jpg",
            icon: Icons.shopping_bag_rounded,
          ),
          BusinessTypeCard(
            title: "Restaurants & Cafés",
            description:
                "Table management, kitchen display systems, and ingredient tracking.",
            imagePath: "assets/business_restaurant.jpg",
            icon: Icons.restaurant_rounded,
          ),
          BusinessTypeCard(
            title: "Home-Based",
            description:
                "Lightweight tools for side hustles, freelancers, and crafters.",
            imagePath: "assets/business_home.jpg",
            icon: Icons.home_work_rounded,
          ),
        ],
      );
    }

    return Row(
      children: const [
        Expanded(
          child: BusinessTypeCard(
            title: "Retail Stores",
            description:
                "Manage SKUs, variants, and multi-location stock with ease.",
            imagePath: "assets/business_retail.jpg",
            icon: Icons.shopping_bag_rounded,
          ),
        ),
        SizedBox(width: 28),
        Expanded(
          child: BusinessTypeCard(
            title: "Restaurants & Cafés",
            description:
                "Table management, kitchen display systems, and ingredient tracking.",
            imagePath: "assets/business_restaurant.jpg",
            icon: Icons.restaurant_rounded,
          ),
        ),
        SizedBox(width: 28),
        Expanded(
          child: BusinessTypeCard(
            title: "Home-Based",
            description:
                "Lightweight tools for side hustles, freelancers, and crafters.",
            imagePath: "assets/business_home.jpg",
            icon: Icons.home_work_rounded,
          ),
        ),
      ],
    );
  }
}

class BusinessTypeCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final IconData icon;

  const BusinessTypeCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final w = MediaQuery.of(context).size.width;
    final isMobile = R.isMobile(w);

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: isMobile ? 300 : 360,
        decoration: BoxDecoration(
          border: Border.all(color: c.border.withOpacity(0.4)),
        ),
        child: Stack(
          children: [
            /// IMAGE
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    alignment: Alignment.center,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Text(
                      "Preview coming soon",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  );
                },
              ),
            ),

            /// OVERLAY
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      c.background.withOpacity(0.1),
                      c.background.withOpacity(0.75),
                    ],
                  ),
                ),
              ),
            ),

            /// CONTENT
            Padding(
              padding: EdgeInsets.all(isMobile ? 18 : 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ICON
                  Container(
                    width: isMobile ? 36 : 40,
                    height: isMobile ? 36 : 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: c.primary.withOpacity(0.2),
                    ),
                    child: Icon(
                      icon,
                      color: c.primary,
                      size: isMobile ? 18 : 20,
                    ),
                  ),

                  const Spacer(),

                  /// TITLE
                  Text(
                    title,
                    style: TextStyle(
                      color: c.textPrimary,
                      fontSize: isMobile ? 16.5 : 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),

                  /// DESCRIPTION
                  Text(
                    description,
                    style: TextStyle(
                      color: c.textSecondary.withOpacity(0.9),
                      fontSize: isMobile ? 14 : 14.5,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
