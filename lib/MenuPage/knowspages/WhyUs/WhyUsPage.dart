import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:menuweb/MenuPage/customWebAppBar/customWebAppBar.dart';
import 'package:menuweb/MenuPage/knowspages/WhyUs/WhyUsService.dart';
import 'package:url_launcher/url_launcher.dart';

class WhyUsPage extends StatefulWidget {
  const WhyUsPage({super.key});

  @override
  State<WhyUsPage> createState() => _WhyUsPageState();
}

class _WhyUsPageState extends State<WhyUsPage> {
  final service = WhyUsService();
  bool loading = true;
  Map<String, dynamic>? data;
  bool get _hasAnySocial =>
      (data?["facebook"] != null && data!["facebook"] != "") ||
      (data?["instagram"] != null && data!["instagram"] != "") ||
      (data?["whatsapp"] != null && data!["whatsapp"] != "") ||
      (data?["tiktok"] != null && data!["tiktok"] != "") ||
      (data?["website"] != null && data!["website"] != "");

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    data = await service.loadWhyUsData();

    // اطبع القيم
    print("🔥 WHY US DATA => $data");

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: customWebAppBar(context),

      body: Skeletonizer(
        enabled: loading,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),

                // HEADER IMAGE
                if (_hasHeader)
                  Container(
                    width: screenWidth > 900 ? 900 : screenWidth * 0.95,
                    height: 260,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://images.unsplash.com/photo-1556910103-1c02745aae4d",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.35),
                      ),
                      child: _headerText(),
                    ),
                  ),

                if (_hasHeader) const SizedBox(height: 40),

                // OUR STORY
                if (_hasStory)
                  Container(
                    width: screenWidth > 900 ? 900 : screenWidth * 0.92,
                    child: _ourStoryText(),
                  ),

                if (_hasStory) const SizedBox(height: 40),

                // CONTACT + HOURS
                if (_hasContact || _hasHours)
                  Container(
                    width: screenWidth > 900 ? 900 : screenWidth * 0.95,
                    child: screenWidth > 700
                        ? Row(
                            children: [
                              if (_hasContact)
                                Expanded(child: _buildContactCard()),
                              if (_hasContact && _hasHours)
                                const SizedBox(width: 20),
                              if (_hasHours) Expanded(child: _buildHoursCard()),
                            ],
                          )
                        : Column(
                            children: [
                              if (_hasContact) _buildContactCard(),
                              if (_hasContact && _hasHours)
                                const SizedBox(height: 20),
                              if (_hasHours) _buildHoursCard(),
                            ],
                          ),
                  ),
                if (_hasAnySocial)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: _buildSocialIcons(),
                  ),

                const SizedBox(height: 60),

                // SOCIAL ICONS SECTION
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =======================
  // DATA CHECKERS
  // =======================

  bool get _hasHeader =>
      (data?["headerTitle"] != null && data?["headerTitle"] != "") ||
      (data?["headerSubtitle"] != null && data?["headerSubtitle"] != "");

  bool get _hasStory =>
      (data?["storyTitle"] != null && data?["storyTitle"] != "") ||
      (data?["storyBody"] != null && data?["storyBody"] != "");

  bool get _hasContact =>
      (data?["address"] != null && data?["address"] != "") ||
      (data?["phone"] != null && data?["phone"] != "") ||
      (data?["email"] != null && data?["email"] != "");

  bool get _hasHours =>
      (data?["hours"] != null &&
      data?["hours"] is List &&
      data!["hours"].isNotEmpty);

  // ================= HEADER TEXT =================
  Widget _headerText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (data?["headerTitle"] != null)
          Text(
            data?["headerTitle"],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

        if (data?["headerTitle"] != null) const SizedBox(height: 6),

        if (data?["headerSubtitle"] != null)
          Text(
            data?["headerSubtitle"],
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
      ],
    );
  }

  // ================= STORY TEXT =================
  Widget _ourStoryText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (data?["storyTitle"] != null)
          Text(
            data?["storyTitle"],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

        if (data?["storyTitle"] != null) const SizedBox(height: 12),

        if (data?["storyBody"] != null)
          Text(
            data?["storyBody"],
            style: const TextStyle(fontSize: 15, height: 1.6),
          ),
      ],
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (data?["facebook"] != null && data!["facebook"] != "")
          _socialIcon(Icons.facebook, data!["facebook"], Colors.blue),

        if (data?["instagram"] != null && data!["instagram"] != "")
          _socialIcon(Icons.camera_alt, data!["instagram"], Colors.purple),

        if (data?["whatsapp"] != null && data!["whatsapp"] != "")
          _socialIcon(Icons.message, data!["whatsapp"], Colors.green),

        if (data?["tiktok"] != null && data!["tiktok"] != "")
          _socialIcon(Icons.music_note, data!["tiktok"], Colors.black),

        if (data?["website"] != null && data!["website"] != "")
          _socialIcon(Icons.language, data!["website"], Colors.blueGrey),
      ],
    );
  }

  Widget _socialIcon(IconData icon, String url, Color color) {
    return InkWell(
      onTap: () => _openUrl(url),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Icon(icon, size: 32, color: color),
      ),
    );
  }

  // ================= CONTACT CARD =================
  Widget _buildContactCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Get in Touch",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          if (data?["address"] != null)
            _iconRow(Icons.location_on, data!["address"]),

          if (data?["phone"] != null) _iconRow(Icons.phone, data!["phone"]),

          if (data?["email"] != null) _iconRow(Icons.email, data!["email"]),
        ],
      ),
    );
  }

  Widget _iconRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  // ================= HOURS CARD =================
  Widget _buildHoursCard() {
    final hours = data?["hours"] as List<dynamic>? ?? [];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Opening Hours",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          ...hours.map((h) {
            return _hoursRow(h["day"], h["time"]);
          }).toList(),
        ],
      ),
    );
  }

  Widget _hoursRow(String day, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(day), Text(time)],
      ),
    );
  }

  void _openUrl(String? url) async {
    if (url == null || url.isEmpty) return;

    final uri = Uri.parse(url.startsWith("http") ? url : "https://$url");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // ================= DECORATION =================
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
