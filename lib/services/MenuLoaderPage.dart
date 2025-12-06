import 'package:flutter/material.dart';
import 'package:menuweb/MenuPage/defaultmenu/service/MenuServicePage.dart';

class MenuLoaderPage extends StatefulWidget {
  const MenuLoaderPage({super.key});

  @override
  State<MenuLoaderPage> createState() => _MenuLoaderPageState();
}

class _MenuLoaderPageState extends State<MenuLoaderPage> {
  String? uid;
  String designKey = "default";
  bool error = false;

  @override
  void initState() {
    super.initState();
    _extractFromUrl();
  }

  void _extractFromUrl() {
    final uri = Uri.base;
    final segments = uri.pathSegments;

    try {
      // رابط مثل:
      // /menu/u/UID
      if (segments.length >= 3 && segments[0] == "menu" && segments[1] == "u") {
        uid = segments[2];
      }

      if (uri.queryParameters.containsKey("designKey")) {
        designKey = uri.queryParameters["designKey"]!;
      }
    } catch (_) {
      error = true;
    }

    // لو uid غير موجود
    if (uid == null) {
      setState(() => error = true);
      return;
    }

    // تحويل مباشر إلى MenuPage بدون البحث عن متاجر
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MenuServicePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      return const Scaffold(body: Center(child: Text("رابط غير صحيح")));
    }

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
