import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  // 🌑 Backgrounds
  final Color background; // Main page background
  final Color backgroundSoft; // Light section backgrounds

  // 🧱 Surfaces
  final Color surface; // Cards / Sections
  final Color surfaceSoft; // Containers inside cards
  final Color border; // Light borders

  // 🌿 Brand / Actions
  final Color primary; // Main brand color
  final Color primaryHover; // Hover / Focus state
  final Color primaryGlow; // Glow effects
  final Color onPrimary; // Text/Icon on primary background

  // 📝 Text
  final Color textPrimary; // Headings
  final Color textSecondary; // Body text
  final Color textMuted; // Footer / hints

  // 🎯 Status Colors
  final Color success;
  final Color warning;
  final Color error;
  final Color card; // Alias for surface for backward compatibility

  const AppColors({
    required this.background,
    required this.backgroundSoft,
    required this.surface,
    required this.surfaceSoft,
    required this.border,
    required this.primary,
    required this.primaryHover,
    required this.primaryGlow,
    required this.onPrimary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.success,
    required this.warning,
    required this.error,
  }) : card = surface; // Initialize card as an alias for surface

  // Constructor for backward compatibility
  const AppColors.legacy({
    required Color primary,
    required Color background,
    required Color card,
    required Color textPrimary,
    required Color textSecondary,
    required Color success,
    required Color warning,
    required Color error,
  }) : this(
         background: background,
         backgroundSoft: background,
         surface: card,
         surfaceSoft: card,
         border: Colors.grey,
         primary: primary,
         primaryHover: primary,
         primaryGlow: primary,
         onPrimary: Colors.white,
         textPrimary: textPrimary,
         textSecondary: textSecondary,
         textMuted: textSecondary,
         success: success,
         warning: warning,
         error: error,
       );

  // 🌟 Light Theme
  static const light = AppColors.legacy(
    primary: Color(0xFF28A745),
    background: Color(0xFFF6F7FB),
    card: Colors.white,
    textPrimary: Color(0xFF1A1A1A),
    textSecondary: Color(0xFF6A6A6A),
    success: Color(0xFF28A745),
    warning: Color(0xFFFFC107),
    error: Color(0xFFDC3545),
  );

  // 🌙 Dark Theme (Suda Official)
  static const dark = AppColors(
    // Backgrounds
    background: Color(0xFF0B1511),
    backgroundSoft: Color(0xFF0F1C16),

    // Surfaces
    surface: Color(0xFF111F18),
    surfaceSoft: Color(0xFF162820),
    border: Color(0xFF1F3A2E),

    // Brand
    primary: Color(0xFF38F28E),
    primaryHover: Color(0xFF5AF5A3),
    primaryGlow: Color(0x8038F28E),
    onPrimary: Color(0xFF08140F),

    // Text
    textPrimary: Color(0xFFE6FFF2),
    textSecondary: Color(0xFF9FBFB1),
    textMuted: Color(0xFF6F8F82),

    // Status
    success: Color(0xFF4CAF50),
    warning: Color(0xFFFFD54F),
    error: Color(0xFFFF5252),
  );

  // 🎨 Optional: High Contrast Dark Theme
  static const highContrastDark = AppColors(
    // Backgrounds
    background: Color(0xFF000000),
    backgroundSoft: Color(0xFF0A0A0A),

    // Surfaces
    surface: Color(0xFF121212),
    surfaceSoft: Color(0xFF1A1A1A),
    border: Color(0xFF2A2A2A),

    // Brand
    primary: Color(0xFF38F28E),
    primaryHover: Color(0xFF5AF5A3),
    primaryGlow: Color(0x8038F28E),
    onPrimary: Color(0xFF000000),

    // Text
    textPrimary: Colors.white,
    textSecondary: Color(0xFFCCCCCC),
    textMuted: Color(0xFF888888),

    // Status
    success: Color(0xFF00E676),
    warning: Color(0xFFFF9100),
    error: Color(0xFFFF1744),
  );

  // ✨ Optional: Light Theme (Suda style)
  static const sudaLight = AppColors(
    // Backgrounds
    background: Color(0xFFF5FDF9),
    backgroundSoft: Color(0xFFE8F8F0),

    // Surfaces
    surface: Colors.white,
    surfaceSoft: Color(0xFFF5FDF9),
    border: Color(0xFFD1EAE0),

    // Brand
    primary: Color(0xFF00C853),
    primaryHover: Color(0xFF00E676),
    primaryGlow: Color(0x1A00C853),
    onPrimary: Colors.white,

    // Text
    textPrimary: Color(0xFF0A291C),
    textSecondary: Color(0xFF4A6B5D),
    textMuted: Color(0xFF8A9C94),

    // Status
    success: Color(0xFF00C853),
    warning: Color(0xFFFF9800),
    error: Color(0xFFFF3D00),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? backgroundSoft,
    Color? surface,
    Color? surfaceSoft,
    Color? border,
    Color? primary,
    Color? primaryHover,
    Color? primaryGlow,
    Color? onPrimary,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? success,
    Color? warning,
    Color? error,
  }) {
    return AppColors(
      background: background ?? this.background,
      backgroundSoft: backgroundSoft ?? this.backgroundSoft,
      surface: surface ?? this.surface,
      surfaceSoft: surfaceSoft ?? this.surfaceSoft,
      border: border ?? this.border,
      primary: primary ?? this.primary,
      primaryHover: primaryHover ?? this.primaryHover,
      primaryGlow: primaryGlow ?? this.primaryGlow,
      onPrimary: onPrimary ?? this.onPrimary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      backgroundSoft: Color.lerp(backgroundSoft, other.backgroundSoft, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSoft: Color.lerp(surfaceSoft, other.surfaceSoft, t)!,
      border: Color.lerp(border, other.border, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      primaryGlow: Color.lerp(primaryGlow, other.primaryGlow, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }

  // Helper methods for quick access
  Color get cardColor => surface;

  // Generate shades from primary color
  List<Color> get primaryShades => [
    primary.withOpacity(0.1),
    primary.withOpacity(0.3),
    primary.withOpacity(0.5),
    primary,
    primary.withOpacity(0.8),
  ];
}

// ---------------------------------------------------------
// 🎨 Theme Data Helper
// ---------------------------------------------------------
extension ThemeDataExtensions on ThemeData {
  AppColors get appColors => extension<AppColors>()!;
}

// ---------------------------------------------------------
// 📱 Theme Provider Example
// ---------------------------------------------------------
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    extensions: const <ThemeExtension<dynamic>>[AppColors.light],
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF3E64FF),
      background: Color(0xFFF6F7FB),
      surface: Colors.white,
      onPrimary: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    extensions: const <ThemeExtension<dynamic>>[AppColors.dark],
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF38F28E),
      background: Color(0xFF0B1511),
      surface: Color(0xFF111F18),
      onPrimary: Color(0xFF08140F),
    ),
  );

  static ThemeData sudaLightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    extensions: const <ThemeExtension<dynamic>>[AppColors.sudaLight],
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF00C853),
      background: Color(0xFFF5FDF9),
      surface: Colors.white,
      onPrimary: Colors.white,
    ),
  );

  static ThemeData highContrastDarkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    extensions: const <ThemeExtension<dynamic>>[AppColors.highContrastDark],
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF38F28E),
      background: Colors.black,
      surface: Color(0xFF121212),
      onPrimary: Colors.black,
    ),
  );
}

// ---------------------------------------------------------
// 📝 Usage Example
// ---------------------------------------------------------
class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;

    return Container(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Card with surface color
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Description text goes here',
                    style: TextStyle(color: colors.textSecondary, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: colors.onPrimary,
                    ),
                    onPressed: () {},
                    child: const Text('Primary Action'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Status indicators
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Success',
                  style: TextStyle(
                    color: colors.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Warning',
                  style: TextStyle(
                    color: colors.warning,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Error',
                  style: TextStyle(
                    color: colors.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
