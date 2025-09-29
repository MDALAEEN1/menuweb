import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:menuweb/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MenuApp());
}

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String? storeId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // قراءة storeId من الرابط
    final uri = Uri.base; // ex: https://domain.com/menu/cafemoka
    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == "menu") {
      setState(() {
        storeId = uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (storeId == null) {
      return const Scaffold(body: Center(child: Text("لم يتم تحديد مطعم")));
    }

    final storeRef = FirebaseFirestore.instance
        .collection("menus")
        .doc(storeId);

    return Scaffold(
      appBar: AppBar(title: Text("منيو: $storeId"), centerTitle: true),
      body: FutureBuilder<DocumentSnapshot>(
        future: storeRef.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("المطعم غير موجود"));
          }

          final storeData = snapshot.data!.data() as Map<String, dynamic>;
          final name = storeData["name"] ?? "مطعم";

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: storeRef.collection("items").snapshots(),
                  builder: (context, itemsSnap) {
                    if (itemsSnap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!itemsSnap.hasData || itemsSnap.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("لا يوجد عناصر في المنيو"),
                      );
                    }

                    return ListView(
                      children: itemsSnap.data!.docs.map((doc) {
                        final item = doc.data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(item["name"] ?? "بدون اسم"),
                          trailing: Text(
                            "${item["price"] ?? 0} \$",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
