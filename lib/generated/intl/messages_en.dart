// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "Shopping Cart (${count})";

  static String m1(error) => "Failed to place order: ${error}";

  static String m2(orderNumber) =>
      "Order placed successfully! Order number: ${orderNumber}";

  static String m3(count) => "Subtotal (${count})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "BestSellers": MessageLookupByLibrary.simpleMessage("Best Sellers"),
    "SearchProducts": MessageLookupByLibrary.simpleMessage(
      "Search products...",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Address *"),
    "addressHint": MessageLookupByLibrary.simpleMessage(
      "Enter your full address",
    ),
    "addressRequiredError": MessageLookupByLibrary.simpleMessage(
      "Please enter your address for delivery.",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cart": MessageLookupByLibrary.simpleMessage("Cart"),
    "cartClearAll": MessageLookupByLibrary.simpleMessage("Clear All"),
    "cartEmptyBrowse": MessageLookupByLibrary.simpleMessage("Browse Products"),
    "cartEmptyError": MessageLookupByLibrary.simpleMessage(
      "Your cart is empty.",
    ),
    "cartEmptySubtitle": MessageLookupByLibrary.simpleMessage(
      "Add some products to see them here.",
    ),
    "cartEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Your cart is empty",
    ),
    "cartTitle": m0,
    "checkoutTitle": MessageLookupByLibrary.simpleMessage("Checkout"),
    "clearAll": MessageLookupByLibrary.simpleMessage("Clear All"),
    "clearCart": MessageLookupByLibrary.simpleMessage("Clear Cart"),
    "clearCartConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to remove all items from the cart?",
    ),
    "customerInfo": MessageLookupByLibrary.simpleMessage(
      "Customer Information",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteProduct": MessageLookupByLibrary.simpleMessage("Delete Product"),
    "deleteProductConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this item from the cart?",
    ),
    "delivery": MessageLookupByLibrary.simpleMessage("Delivery"),
    "deliveryMethod": MessageLookupByLibrary.simpleMessage("Delivery Method"),
    "deliverySubtitle": MessageLookupByLibrary.simpleMessage(
      "Delivered to your address",
    ),
    "footerBrandDescription": MessageLookupByLibrary.simpleMessage(
      "Your trusted destination for a seamless shopping experience.",
    ),
    "footerBrandName": MessageLookupByLibrary.simpleMessage("StoreLogo"),
    "footerFollowUs": MessageLookupByLibrary.simpleMessage("Follow Us"),
    "footerRights": MessageLookupByLibrary.simpleMessage(
      "© 2024 suda. All Rights Reserved.",
    ),
    "fullName": MessageLookupByLibrary.simpleMessage("Full Name *"),
    "fullNameHint": MessageLookupByLibrary.simpleMessage(
      "Enter your full name",
    ),
    "heroButton": MessageLookupByLibrary.simpleMessage("Shop Now"),
    "heroSubtitle": MessageLookupByLibrary.simpleMessage(
      "Explore our curated selection of quality products crafted to fit every style and need.",
    ),
    "heroTitle": MessageLookupByLibrary.simpleMessage(
      "Discover Your Signature\nStyle",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Menu"),
    "nameRequiredError": MessageLookupByLibrary.simpleMessage(
      "Please enter your full name.",
    ),
    "newArrivals": MessageLookupByLibrary.simpleMessage("New Arrivals"),
    "notes": MessageLookupByLibrary.simpleMessage("Additional Notes"),
    "notesExample": MessageLookupByLibrary.simpleMessage(
      "Example: leave at the door, call before delivery, etc.",
    ),
    "notesHint": MessageLookupByLibrary.simpleMessage(
      "Special instructions for your order (optional)",
    ),
    "orderFailed": m1,
    "orderSuccess": m2,
    "orderSummary": MessageLookupByLibrary.simpleMessage("Order Summary"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number *"),
    "phoneNumberHint": MessageLookupByLibrary.simpleMessage("+962 79 123 4567"),
    "phoneRequiredError": MessageLookupByLibrary.simpleMessage(
      "Please enter your phone number.",
    ),
    "pickup": MessageLookupByLibrary.simpleMessage("Pickup"),
    "pickupSubtitle": MessageLookupByLibrary.simpleMessage("Pickup from store"),
    "placeOrder": MessageLookupByLibrary.simpleMessage("Place Order"),
    "placeOrderAgreement": MessageLookupByLibrary.simpleMessage(
      "By placing this order, you agree to the terms & conditions.",
    ),
    "productAddOns": MessageLookupByLibrary.simpleMessage("Add-ons"),
    "productAddToCart": MessageLookupByLibrary.simpleMessage("Add to Cart"),
    "productYouMightAlsoLike": MessageLookupByLibrary.simpleMessage(
      "You Might Also Like",
    ),
    "promoCodeHint": MessageLookupByLibrary.simpleMessage("Enter promo code"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchHint": MessageLookupByLibrary.simpleMessage("Search products..."),
    "secureInfo": MessageLookupByLibrary.simpleMessage(
      "Your information is protected and safe. We do not store your bank data.",
    ),
    "shipping": MessageLookupByLibrary.simpleMessage("Shipping Fee"),
    "shopByCategory": MessageLookupByLibrary.simpleMessage("Shop by Category"),
    "subtotal": MessageLookupByLibrary.simpleMessage("Subtotal"),
    "summaryCheckout": MessageLookupByLibrary.simpleMessage("Checkout"),
    "summaryNote": MessageLookupByLibrary.simpleMessage(
      "Shipping and taxes will be calculated at checkout.",
    ),
    "summaryShipping": MessageLookupByLibrary.simpleMessage("Shipping Fee"),
    "summarySubtotal": m3,
    "summaryTax": MessageLookupByLibrary.simpleMessage("Tax"),
    "summaryTitle": MessageLookupByLibrary.simpleMessage("Order Summary"),
    "summaryTotal": MessageLookupByLibrary.simpleMessage("Total"),
    "tax": MessageLookupByLibrary.simpleMessage("Tax (10%)"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "userNotFoundError": MessageLookupByLibrary.simpleMessage(
      "User not found.",
    ),
    "whyUs": MessageLookupByLibrary.simpleMessage("Why Us"),
  };
}
