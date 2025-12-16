import 'package:flutter/material.dart';
import 'package:menuweb/homepage/mainpage/pages/ChooseBusinessTypePage.dart';
import 'package:menuweb/homepage/mainpage/pages/DownloadPage.dart';
import 'package:menuweb/homepage/mainpage/pages/HowWorks.dart';
import 'package:menuweb/homepage/mainpage/pages/landing_page.dart';
import 'package:menuweb/homepage/mainpage/pages/web%20application/stitch/projects/sudafeaturespage.dart';
import 'package:menuweb/menu/MenuPage/CheckoutPage/CheckoutPage.dart';
import 'package:menuweb/menu/MenuPage/cartpage/cartpage.dart';
import 'package:menuweb/menu/MenuPage/defaultmenu/service/MenuServicePage.dart';
import 'package:menuweb/menu/MenuPage/knowspages/WhyUs/WhyUsPage.dart';
import 'package:menuweb/menu/MenuPage/knowspages/SupportPage.dart';
import 'package:menuweb/menu/MenuPage/knowspages/ContactPage.dart';
import 'package:menuweb/menu/MenuPage/product_details_page/product_details_page.dart';
import 'package:menuweb/menu/Retail_menu/catagory_page/catagory_page.dart';
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
        page = sudafeaturespage();
        break;
      case "/BusinessType":
        page = ChooseBusinessTypePage();
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
      case "/Home":
        page = LandingPage();
        break;
      case "/HowWorks":
        page = HowWorks();
        break;
      case "/Download":
        page = DownloadPage();
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
