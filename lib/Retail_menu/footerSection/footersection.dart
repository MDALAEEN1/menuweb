import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  final double horizontalPadding;
  final bool isMobile;

  const FooterSection({
    required this.horizontalPadding,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      color: colors.card,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 24,
      ),
      child: Column(
        children: [
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FooterTopRow(isMobile: isMobile),
                const SizedBox(height: 24),
                _FooterBottomRow(),
              ],
            )
          else
            Column(
              children: [
                _FooterTopRow(isMobile: isMobile),
                const SizedBox(height: 24),
                _FooterBottomRow(),
              ],
            ),
        ],
      ),
    );
  }
}

class _FooterTopRow extends StatelessWidget {
  final bool isMobile;
  const _FooterTopRow({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [_FooterBrand(), SizedBox(height: 16), _FooterSocial()],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(flex: 2, child: _FooterBrand()),
        SizedBox(width: 32),
        _FooterSocial(),
      ],
    );
  }
}

class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final box = Hive.box("menu_cache");
    final uid = box.get("uid");
    final storeName = box.get("storeName_$uid") ?? "";
    final storeImage = box.get("storeImage_$uid");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            storeImage.isEmpty
                ? Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      storeImage,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),

            const SizedBox(width: 8),
            Text(
              storeName.isEmpty ? S.of(context).footerBrandName : storeName,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Text(
          S.of(context).footerBrandDescription,
          style: TextStyle(
            fontSize: 12,
            color: colors.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _FooterSocial extends StatelessWidget {
  const _FooterSocial();

  @override
  Widget build(BuildContext context) {
    final box = Hive.box("menu_cache");
    final uid = box.get("uid");
    final Map social = box.get("social_$uid") ?? {};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Follow Us",
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            if (social["facebook"] != null) ...[
              _iconButton(Icons.facebook, social["facebook"]),
              const SizedBox(width: 8),
            ],
            if (social["instagram"] != null) ...[
              _iconButton(Icons.camera_alt_outlined, social["instagram"]),
              const SizedBox(width: 8),
            ],
            if (social["telegram"] != null) ...[
              _iconButton(Icons.telegram, social["telegram"]),
              const SizedBox(width: 8),
            ],
            if (social["tiktok"] != null) ...[
              _iconButton(Icons.music_note, social["tiktok"]),
            ],
          ],
        ),
      ],
    );
  }

  Widget _iconButton(IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Icon(icon, size: 18),
    );
  }
}

class _FooterBottomRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).footerRights,
      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
      textAlign: TextAlign.center,
    );
  }
}
