import 'package:flutter/material.dart';
import 'package:menuweb/MenuPage/CheckoutPage/CheckoutPage.dart';
import 'package:menuweb/MenuPage/cartpage/cartpage.dart';
import 'package:menuweb/MenuPage/defaultmenu/service/MenuServicePage.dart';
import 'package:menuweb/MenuPage/knowspages/WhyUs/WhyUsPage.dart';
import 'package:menuweb/MenuPage/knowspages/SupportPage.dart';
import 'package:menuweb/MenuPage/knowspages/ContactPage.dart';
import 'package:menuweb/MenuPage/product_details_page/product_details_page.dart';
import 'package:menuweb/Retail_menu/catagory_page/catagory_page.dart';
import 'package:menuweb/services/MenuLoaderPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case "/":
        page = const MenuServicePage();
        break;
      case "/Menu":
        page = MenuLoaderPage();
        break;

      case "/whyus":
        page = WhyUsPage();
        break;
      case "/support":
        page = SupportPage();
        break;
      case "/contact":
        page = ContactPage();
        break;
      case "/cart":
        page = CartPage();
        break;
      case "/Checkout":
        page = CheckoutPage();
        break;
      case "/categoryProducts":
        final args = settings.arguments as Map?;
        page = ShirtsPage(args: args);
        break;

      case "/productDetails":
        final product = settings.arguments as Map<String, dynamic>;
        page = ProductDetailsUI(product: product);
        break;

      default:
        page = const Scaffold(
          body: Center(child: Text("404 – Page Not Found")),
        );
    }

    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 150),

      pageBuilder: (_, animation, __) {
        return FadeTransition(opacity: animation, child: page);
      },
    );
  }
}
