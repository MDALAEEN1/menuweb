import 'package:flutter/material.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/homepage/mainpage/assets/NavBar.dart';
import 'package:menuweb/homepage/mainpage/assets/responsive.dart';

class HowWorks extends StatelessWidget {
  const HowWorks({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: c.background,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            NavBar(),
            HeroAutopilotSection(),
            EcosystemSection(),
            LaunchFastSection(),
            InventorySection(),
            SellAnywhereSection(),
            AnalyticsSection(),
            CTASection(),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class HeroAutopilotSection extends StatelessWidget {
  const HeroAutopilotSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return LayoutBuilder(
      builder: (context, cst) {
        final w = cst.maxWidth;
        final pad = R.pagePad(w);

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: pad,
            vertical: R.isMobile(w) ? 72 : 110,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [c.primaryGlow.withOpacity(0.35), c.background],
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: c.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "NEW FEATURE · AUTOPILOT",
                  style: TextStyle(
                    color: c.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Run your business on\nautopilot.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: c.textPrimary,
                  fontSize: R.heroTitle(w),
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                "Suda connects your online store, inventory,\nand POS into a single powerful workflow.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: c.textSecondary,
                  fontSize: R.isMobile(w) ? 15 : 17,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 12,
                children: const [
                  PrimaryButton("Watch Demo"),
                  OutlineButtonCustom("View Documentation"),
                ],
              ),
              const SizedBox(height: 64),
              _DashboardMock(w: w),
            ],
          ),
        );
      },
    );
  }
}

class _DashboardMock extends StatelessWidget {
  final double w;
  const _DashboardMock({required this.w});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return Container(
      height: R.isMobile(w) ? 260 : 420,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: c.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: const Center(child: Icon(Icons.play_circle, size: 56)),
    );
  }
}

class EcosystemSection extends StatelessWidget {
  const EcosystemSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return LayoutBuilder(
      builder: (context, cst) {
        final w = cst.maxWidth;
        final pad = R.pagePad(w);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: pad, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "The Ecosystem",
                style: TextStyle(
                  color: c.textPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  _EcoPill("Online Store", active: true),
                  _EcoPill("Inventory"),
                  _EcoPill("POS System"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EcoPill extends StatelessWidget {
  final String title;
  final bool active;
  const _EcoPill(this.title, {this.active = false});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: active ? c.primary : c.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: active ? Colors.black : c.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class LaunchFastSection extends StatelessWidget {
  const LaunchFastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _SplitSection(
      title: "Launch in minutes,\nnot months.",
      desc:
          "Create and deploy your store using real workflows, prebuilt templates, and zero friction setup.",
      bullets: const [
        "No coding required",
        "Mobile-ready templates",
        "Built-in SEO tools",
      ],
    );
  }
}

class InventorySection extends StatelessWidget {
  const InventorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return _SplitSection(
      reverse: true,
      title: "Never run out\nof stock again.",
      desc:
          "Track products in real time, receive alerts, and automate purchasing before problems happen.",
      bullets: const [
        "Real-time stock alerts",
        "Low-stock automation",
        "Smart reorder rules",
      ],
    );
  }
}

class SellAnywhereSection extends StatelessWidget {
  const SellAnywhereSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _SplitSection(
      title: "Sell anywhere,\nsync everywhere.",
      desc:
          "Accept payments online or in-store. Everything stays synced across all channels.",
      bullets: const ["Online payments", "Offline POS", "Automatic sync"],
    );
  }
}

class AnalyticsSection extends StatelessWidget {
  const AnalyticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, cst) {
        final w = cst.maxWidth;
        final pad = R.pagePad(w);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: pad, vertical: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Know your numbers.",
                style: TextStyle(
                  color: Theme.of(context).extension<AppColors>()!.textPrimary,
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Visualize profits, trends, and customer behavior in real time.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).extension<AppColors>()!.textSecondary,
                ),
              ),
              const SizedBox(height: 48),
              Container(
                height: R.isMobile(w) ? 220 : 320,
                decoration: BoxDecoration(
                  color: Theme.of(context).extension<AppColors>()!.surface,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: Theme.of(context).extension<AppColors>()!.border,
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

class _SplitSection extends StatelessWidget {
  final String title;
  final String desc;
  final List<String> bullets;
  final bool reverse;

  const _SplitSection({
    super.key,
    required this.title,
    required this.desc,
    required this.bullets,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;

    return LayoutBuilder(
      builder: (context, cst) {
        final w = cst.maxWidth;
        final pad = R.pagePad(w);
        final gap = R.gap(w);
        final isMobile = R.isMobile(w);

        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: c.textPrimary,
                fontSize: isMobile ? 26 : 34,
                height: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: gap),
            Text(
              desc,
              style: TextStyle(
                color: c.textSecondary,
                height: 1.6,
                fontSize: isMobile ? 14.5 : 16,
              ),
            ),
            SizedBox(height: gap),
            ...bullets.map(
              (b) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: c.primary, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(b, style: TextStyle(color: c.textSecondary)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

        final visual = Container(
          height: isMobile ? 220 : 320,
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: c.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: const Center(child: Icon(Icons.auto_graph_rounded, size: 48)),
        );

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: pad,
            vertical: isMobile ? 64 : 90,
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    content,
                    SizedBox(height: gap * 2),
                    visual,
                  ],
                )
              : Row(
                  children: reverse
                      ? [
                          Expanded(child: visual),
                          SizedBox(width: gap * 2),
                          Expanded(child: content),
                        ]
                      : [
                          Expanded(child: content),
                          SizedBox(width: gap * 2),
                          Expanded(child: visual),
                        ],
                ),
        );
      },
    );
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

class OutlineButtonCustom extends StatelessWidget {
  final String title;
  const OutlineButtonCustom(this.title);

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<AppColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: c.border),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Text(title, style: TextStyle(color: c.textPrimary)),
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
