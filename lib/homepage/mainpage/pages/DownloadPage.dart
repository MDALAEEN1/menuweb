import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/homepage/mainpage/assets/NavBar.dart';
import 'package:menuweb/homepage/mainpage/assets/responsive.dart';
import 'package:menuweb/homepage/mainpage/pages/landing_page.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(),
            DownloadHeroSection(),
            DesktopFeaturesSection(),
            CommandCenterSection(),

            CTASection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class DownloadHeroSection extends StatelessWidget {
  const DownloadHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return LayoutBuilder(
      builder: (context, cst) {
        final w = cst.maxWidth;
        final pad = R.pagePad(w);
        final isMobile = R.isMobile(w);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [c.primaryGlow.withOpacity(0.35), c.background],
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: pad,
            vertical: isMobile ? 60 : 100,
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DownloadHeroText(context, w),
                    const SizedBox(height: 40),
                    _DownloadHeroPreview(context, w),
                  ],
                )
              : Row(
                  children: [
                    Expanded(flex: 5, child: _DownloadHeroText(context, w)),
                    const SizedBox(width: 48),
                    Expanded(flex: 6, child: _DownloadHeroPreview(context, w)),
                  ],
                ),
        );
      },
    );
  }
}

Widget _DownloadHeroText(BuildContext context, double w) {
  final c = Theme.of(context).extension<AppColors>()!;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: c.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "v2.0 NOW AVAILABLE",
          style: TextStyle(
            color: c.primary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(height: 24),
      Text(
        "Manage your\nbusiness at the\nspeed of thought.",
        style: TextStyle(
          fontSize: R.isMobile(w) ? 32 : 46,
          height: 1.15,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
          color: c.textPrimary,
        ),
      ),
      const SizedBox(height: 18),
      Text(
        "Experience Suda on Desktop. A command center for your entire operation designed for deep work and distraction-free management.",
        style: TextStyle(height: 1.6, color: c.textSecondary, fontSize: 15.5),
      ),
      const SizedBox(height: 28),
      Wrap(
        spacing: 16,
        runSpacing: 12,
        children: [
          const PrimaryButton("Download for Windows"),
          OutlineButtonCustom("Watch Demo", onTap: () {}),
        ],
      ),
      const SizedBox(height: 18),
      Text(
        "macOS • Windows • Linux",
        style: TextStyle(fontSize: 13, color: c.textSecondary.withOpacity(0.7)),
      ),
    ],
  );
}

Widget _DownloadHeroPreview(BuildContext context, double w) {
  final c = Theme.of(context).extension<AppColors>()!;

  return Container(
    height: R.isMobile(w) ? 260 : 360,
    decoration: BoxDecoration(
      color: c.surface,
      borderRadius: BorderRadius.circular(28),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 40,
          offset: const Offset(0, 24),
        ),
      ],
    ),
    child: Center(
      child: Text(
        "Desktop App Preview",
        style: TextStyle(color: c.textSecondary),
      ),
    ),
  );
}

class PrimaryButton extends StatelessWidget {
  final String title;
  const PrimaryButton(this.title);

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        color: c.primary,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Text(
        title,
        style: TextStyle(color: c.textPrimary, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class DesktopFeaturesSection extends StatelessWidget {
  const DesktopFeaturesSection({super.key});

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
              DesktopFeatures(w),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopFeatures extends StatelessWidget {
  final double w;
  const DesktopFeatures(this.w);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (R.isMobile(w)) {
      return Column(
        children: const [
          InfoCard(
            icon: Icons.layers_rounded,
            title: "Advanced Reporting",
            desc:
                "Deep insights with charts and exports optimized for large screens. ",
          ),
          SizedBox(height: 20),
          InfoCard(
            icon: Icons.storefront_rounded,
            title: "Seamless Integration",
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
                "Connect effortlessly with local files, printers, and system tools.",
          ),
        ),
        SizedBox(width: 28),
        Expanded(
          child: InfoCard(
            icon: Icons.flash_on_rounded,
            title: "Offline Mode",
            desc:
                "Keep working without internet. Sync automatically when back online.",
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

class CommandCenterSection extends StatelessWidget {
  const CommandCenterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return LayoutBuilder(
      builder: (context, cst) {
        final w = cst.maxWidth;
        final pad = R.pagePad(w);
        final gap = R.gap(w);
        final isMobile = R.isMobile(w);

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: pad,
            vertical: isMobile ? 70 : 100,
          ),
          child: Column(
            children: [
              Text(
                "Your Command Center",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 26 : 32,
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
              SizedBox(height: gap),
              Text(
                "Everything you need to manage your operation in one focused workspace.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: c.textSecondary,
                  fontSize: isMobile ? 14.5 : 16,
                ),
              ),
              SizedBox(height: gap * 2),

              /// Tabs
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 10,
                children: const [
                  _CommandTab("Dashboard", active: true),
                  _CommandTab("Team View"),
                  _CommandTab("Project Timeline"),
                  _CommandTab("Analytics"),
                ],
              ),

              SizedBox(height: gap * 2),

              /// Screenshot
              Container(
                height: isMobile ? 260 : 420,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: c.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 40,
                      offset: const Offset(0, 24),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Desktop App Screenshot",
                    style: TextStyle(color: c.textSecondary),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CommandTab extends StatelessWidget {
  final String title;
  final bool active;

  const _CommandTab(this.title, {this.active = false});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? c.primary : c.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: active ? c.primary : c.border),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: active ? Colors.black : c.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: 13.5,
        ),
      ),
    );
  }
}
