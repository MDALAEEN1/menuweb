import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/homepage/mainpage/assets/NavBar.dart';
import 'package:menuweb/homepage/mainpage/assets/responsive.dart';

class sudafeaturespage extends StatelessWidget {
  const sudafeaturespage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: c.background,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            NavBar(),
            _HeroSection(),
            _FeaturesGrid(),
            _CTASection(),
            _Footer(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final w = MediaQuery.of(context).size.width;
    final isMobile = R.isMobile(w);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: R.pagePad(w),
        vertical: isMobile ? 64 : 80,
      ),
      child: Column(
        children: [
          /// BADGE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: c.border),
            ),
            child: Text(
              "WHAT'S NEW IN V2.0",
              style: TextStyle(
                color: c.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
            ),
          ),

          SizedBox(height: R.gap(w) * 1.2),

          /// TITLE
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: R.isMobile(w)
                      ? 32
                      : R.isTablet(w)
                      ? 40
                      : 48,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
                children: [
                  TextSpan(
                    text: "All Your Business Tools in\n ",
                    style: TextStyle(color: c.textPrimary),
                  ),
                  TextSpan(
                    text: "One Simple System",
                    style: TextStyle(color: c.primary),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: R.gap(w)),

          /// SUBTITLE
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              "Suda unifies inventory, sales, staff, and accounting into a single, "
              "intuitive platform designed for modern business owners.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: c.textSecondary,
                fontSize: isMobile ? 14.5 : 16,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturesGrid extends StatelessWidget {
  const _FeaturesGrid();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: R.pagePad(w)),
      child: GridView.count(
        crossAxisCount: _cols(w),
        shrinkWrap: true,
        crossAxisSpacing: R.gap(w),
        mainAxisSpacing: R.gap(w),
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: R.isMobile(w)
            ? 1.25
            : R.isTablet(w)
            ? 1.35
            : 1.45,
        children: const [
          _FeatureCard("Inventory Management", Icons.inventory),
          _FeatureCard("POS System", Icons.point_of_sale),
          _FeatureCard("Online Store Builder", Icons.store),
          _FeatureCard("Customer Management", Icons.people),
          _FeatureCard("Accounting Page", Icons.account_balance),
          _FeatureCard("Daily Analytics", Icons.bar_chart),
          _FeatureCard("Staff Management", Icons.groups),
          _FeatureCard("Delivery Driver System", Icons.delivery_dining),
        ],
      ),
    );
  }

  int _cols(double w) {
    if (R.isMobile(w)) return 1;
    if (R.isTablet(w)) return 2;
    return 4;
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _FeatureCard(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final w = MediaQuery.of(context).size.width;
    final isMobile = R.isMobile(w);

    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 24),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: c.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON
          CircleAvatar(
            radius: isMobile ? 18 : 20,
            backgroundColor: c.border,
            child: Icon(icon, color: c.primary, size: isMobile ? 18 : 20),
          ),

          SizedBox(height: isMobile ? 14 : 16),

          /// TITLE
          Text(
            title,
            style: TextStyle(
              color: c.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 15.5 : 16,
            ),
          ),

          const SizedBox(height: 10),

          /// FEATURES (بدون \n يدوي)
          Text(
            "• Feature one\n• Feature two\n• Feature three",
            style: TextStyle(
              color: c.textSecondary,
              height: 1.6,
              fontSize: isMobile ? 13.5 : 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _CTASection extends StatelessWidget {
  const _CTASection();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    final w = MediaQuery.of(context).size.width;
    final isMobile = R.isMobile(w);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: R.pagePad(w),
        vertical: isMobile ? 64 : 80,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 48,
          vertical: isMobile ? 28 : 40,
        ),
        decoration: BoxDecoration(
          color: c.surfaceSoft,
          borderRadius: BorderRadius.circular(28),
        ),
        child: isMobile ? _CTAMobileLayout(c) : _CTADesktopLayout(c),
      ),
    );
  }
}

class _CTAMobileLayout extends StatelessWidget {
  final AppColors c;
  const _CTAMobileLayout(this.c);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CTAText(c, isMobile: true),
        const SizedBox(height: 24),
        _PrimaryButton("Start Free Trial", fullWidth: true),
        const SizedBox(height: 12),
        _GhostButton("View Demo", fullWidth: true),
      ],
    );
  }
}

class _CTADesktopLayout extends StatelessWidget {
  final AppColors c;
  const _CTADesktopLayout(this.c);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _CTAText(c)),
        const SizedBox(width: 24),
        _PrimaryButton("Start Free Trial"),
        const SizedBox(width: 12),
        _GhostButton("View Demo"),
      ],
    );
  }
}

class _CTAText extends StatelessWidget {
  final AppColors c;
  final bool isMobile;

  const _CTAText(this.c, {this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ready to streamline your business?",
          style: TextStyle(
            color: c.textPrimary,
            fontSize: isMobile ? 22 : 28,
            fontWeight: FontWeight.bold,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            "Join thousands of business owners who are saving time "
            "and increasing profits with Suda.",
            style: TextStyle(
              color: c.textSecondary,
              fontSize: isMobile ? 14.5 : 15.5,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool fullWidth;

  const _PrimaryButton(this.title, {this.onTap, this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          color: c.primary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: c.primary.withOpacity(0.25),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: c.onPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool fullWidth;

  const _GhostButton(this.title, {this.onTap, this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: c.border, width: 1),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: c.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

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
