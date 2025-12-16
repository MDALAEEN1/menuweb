import 'package:menuweb/menu/MenuPage/cartpage/cart_service.dart';

class ProductDetailsService {
  static void addProductToCart(
    Map product,
    int qty, {
    required String image,
    required List<Map<String, dynamic>> addons,
    required Map<String, Map<String, dynamic>> choices,
  }) {
    double basePrice = (product["price"] ?? 0).toDouble();

    // مجموع أسعار addons
    double addonsPrice = addons.fold(
      0,
      (sum, a) => sum + (a["extraPrice"] ?? 0),
    );

    // مجموع أسعار choices
    double choicesPrice = choices.entries.fold(
      0,
      (sum, e) => sum + (e.value["extraPrice"] ?? 0),
    );

    double finalPrice = basePrice + addonsPrice + choicesPrice;

    CartService.addItem({
      "id": product["id"], // ← أهم سطر في النظام كله
      "name": product["name"],
      "price": finalPrice,
      "qty": qty,
      "image": image,

      "description": product["description"] ?? "",
      "color": product["color"] ?? "",
      "size": product["size"] ?? "",

      "addons": addons,
      "choices": choices,
    });
  }
}
