import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:menuweb/AppColors/AppColors.dart';
import 'package:menuweb/MenuPage/assets/route_generator.dart';
import 'package:menuweb/generated/l10n.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox('local_cache');
  await Hive.openBox('cart_box'); // صندوق السلة
  await Hive.openBox('menu_cache'); // صندوق السلة

  runApp(const MenuApp());
}

class MenuApp extends StatefulWidget {
  const MenuApp({super.key});

  static _MenuAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MenuAppState>()!;

  @override
  State<MenuApp> createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp> {
  Locale _locale = const Locale('ar');
  bool _isDark = false;

  @override
  void initState() {
    // تحميل الثيم واللغة من Hive
    final box = Hive.box('local_cache');
    final savedLang = box.get('locale');
    final savedTheme = box.get('theme_dark');

    if (savedLang != null) _locale = Locale(savedLang);
    if (savedTheme != null) _isDark = savedTheme;

    super.initState();
  }

  // تغيير اللغة
  void setLocale(Locale locale) {
    Hive.box('local_cache').put('locale', locale.languageCode);
    setState(() => _locale = locale);
  }

  // تغيير الثيم
  void toggleTheme() {
    _isDark = !_isDark;
    Hive.box('local_cache').put('theme_dark', _isDark);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // ❤️ ربط الثيم هنا
      theme: ThemeData(
        brightness: Brightness.light,
        extensions: const [lightAppColors],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        extensions: const [darkAppColors],
      ),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,

      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
