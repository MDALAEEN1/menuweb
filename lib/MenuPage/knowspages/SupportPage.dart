import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customWebAppBar(context),
      body: const Center(
        child: Text(
          "Support Center",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

PreferredSizeWidget customWebAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: 70,
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    title: Row(
      children: [
        const SizedBox(width: 20),

        // Logo
        const Icon(Icons.wifi, color: Colors.blue, size: 28),
        const SizedBox(width: 8),

        const Text(
          "ConnectSphere",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),

    actions: [
      _navButton("Plans", "/plans", context),
      _navButton("Why Us", "/whyus", context),
      _navButton("Support", "/support", context),
      _navButton("Contact", "/contact", context),
      const SizedBox(width: 25),
    ],
  );
}

Widget _navButton(String title, String route, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
