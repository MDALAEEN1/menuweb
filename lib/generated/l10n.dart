// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Menu`
  String get menu {
    return Intl.message('Menu', name: 'menu', desc: '', args: []);
  }

  /// `Why Us`
  String get whyUs {
    return Intl.message('Why Us', name: 'whyUs', desc: '', args: []);
  }

  /// `Search products...`
  String get searchHint {
    return Intl.message(
      'Search products...',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Discover Your Signature\nStyle`
  String get heroTitle {
    return Intl.message(
      'Discover Your Signature\nStyle',
      name: 'heroTitle',
      desc: '',
      args: [],
    );
  }

  /// `Explore our curated selection of quality products crafted to fit every style and need.`
  String get heroSubtitle {
    return Intl.message(
      'Explore our curated selection of quality products crafted to fit every style and need.',
      name: 'heroSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Shop Now`
  String get heroButton {
    return Intl.message('Shop Now', name: 'heroButton', desc: '', args: []);
  }

  /// `New Arrivals`
  String get newArrivals {
    return Intl.message(
      'New Arrivals',
      name: 'newArrivals',
      desc: '',
      args: [],
    );
  }

  /// `Shop by Category`
  String get shopByCategory {
    return Intl.message(
      'Shop by Category',
      name: 'shopByCategory',
      desc: '',
      args: [],
    );
  }

  /// `Best Sellers`
  String get BestSellers {
    return Intl.message(
      'Best Sellers',
      name: 'BestSellers',
      desc: '',
      args: [],
    );
  }

  /// `StoreLogo`
  String get footerBrandName {
    return Intl.message(
      'StoreLogo',
      name: 'footerBrandName',
      desc: '',
      args: [],
    );
  }

  /// `Your trusted destination for a seamless shopping experience.`
  String get footerBrandDescription {
    return Intl.message(
      'Your trusted destination for a seamless shopping experience.',
      name: 'footerBrandDescription',
      desc: '',
      args: [],
    );
  }

  /// `Follow Us`
  String get footerFollowUs {
    return Intl.message(
      'Follow Us',
      name: 'footerFollowUs',
      desc: '',
      args: [],
    );
  }

  /// `© 2024 suda. All Rights Reserved.`
  String get footerRights {
    return Intl.message(
      '© 2024 suda. All Rights Reserved.',
      name: 'footerRights',
      desc: '',
      args: [],
    );
  }

  /// `Add-ons`
  String get productAddOns {
    return Intl.message('Add-ons', name: 'productAddOns', desc: '', args: []);
  }

  /// `Add to Cart`
  String get productAddToCart {
    return Intl.message(
      'Add to Cart',
      name: 'productAddToCart',
      desc: '',
      args: [],
    );
  }

  /// `You Might Also Like`
  String get productYouMightAlsoLike {
    return Intl.message(
      'You Might Also Like',
      name: 'productYouMightAlsoLike',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get cartEmptyTitle {
    return Intl.message(
      'Your cart is empty',
      name: 'cartEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add some products to see them here.`
  String get cartEmptySubtitle {
    return Intl.message(
      'Add some products to see them here.',
      name: 'cartEmptySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Browse Products`
  String get cartEmptyBrowse {
    return Intl.message(
      'Browse Products',
      name: 'cartEmptyBrowse',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Cart ({count})`
  String cartTitle(Object count) {
    return Intl.message(
      'Shopping Cart ($count)',
      name: 'cartTitle',
      desc: '',
      args: [count],
    );
  }

  /// `Clear All`
  String get cartClearAll {
    return Intl.message('Clear All', name: 'cartClearAll', desc: '', args: []);
  }

  /// `Order Summary`
  String get summaryTitle {
    return Intl.message(
      'Order Summary',
      name: 'summaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal ({count})`
  String summarySubtotal(Object count) {
    return Intl.message(
      'Subtotal ($count)',
      name: 'summarySubtotal',
      desc: '',
      args: [count],
    );
  }

  /// `Shipping Fee`
  String get summaryShipping {
    return Intl.message(
      'Shipping Fee',
      name: 'summaryShipping',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get summaryTax {
    return Intl.message('Tax', name: 'summaryTax', desc: '', args: []);
  }

  /// `Total`
  String get summaryTotal {
    return Intl.message('Total', name: 'summaryTotal', desc: '', args: []);
  }

  /// `Checkout`
  String get summaryCheckout {
    return Intl.message(
      'Checkout',
      name: 'summaryCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Shipping and taxes will be calculated at checkout.`
  String get summaryNote {
    return Intl.message(
      'Shipping and taxes will be calculated at checkout.',
      name: 'summaryNote',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkoutTitle {
    return Intl.message('Checkout', name: 'checkoutTitle', desc: '', args: []);
  }

  /// `Delivery Method`
  String get deliveryMethod {
    return Intl.message(
      'Delivery Method',
      name: 'deliveryMethod',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message('Delivery', name: 'delivery', desc: '', args: []);
  }

  /// `Delivered to your address`
  String get deliverySubtitle {
    return Intl.message(
      'Delivered to your address',
      name: 'deliverySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Pickup`
  String get pickup {
    return Intl.message('Pickup', name: 'pickup', desc: '', args: []);
  }

  /// `Pickup from store`
  String get pickupSubtitle {
    return Intl.message(
      'Pickup from store',
      name: 'pickupSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Customer Information`
  String get customerInfo {
    return Intl.message(
      'Customer Information',
      name: 'customerInfo',
      desc: '',
      args: [],
    );
  }

  /// `Full Name *`
  String get fullName {
    return Intl.message('Full Name *', name: 'fullName', desc: '', args: []);
  }

  /// `Enter your full name`
  String get fullNameHint {
    return Intl.message(
      'Enter your full name',
      name: 'fullNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Address *`
  String get address {
    return Intl.message('Address *', name: 'address', desc: '', args: []);
  }

  /// `Enter your full address`
  String get addressHint {
    return Intl.message(
      'Enter your full address',
      name: 'addressHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number *`
  String get phoneNumber {
    return Intl.message(
      'Phone Number *',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `+962 79 123 4567`
  String get phoneNumberHint {
    return Intl.message(
      '+962 79 123 4567',
      name: 'phoneNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Additional Notes`
  String get notes {
    return Intl.message('Additional Notes', name: 'notes', desc: '', args: []);
  }

  /// `Special instructions for your order (optional)`
  String get notesHint {
    return Intl.message(
      'Special instructions for your order (optional)',
      name: 'notesHint',
      desc: '',
      args: [],
    );
  }

  /// `Example: leave at the door, call before delivery, etc.`
  String get notesExample {
    return Intl.message(
      'Example: leave at the door, call before delivery, etc.',
      name: 'notesExample',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get orderSummary {
    return Intl.message(
      'Order Summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Shipping Fee`
  String get shipping {
    return Intl.message('Shipping Fee', name: 'shipping', desc: '', args: []);
  }

  /// `Tax (10%)`
  String get tax {
    return Intl.message('Tax (10%)', name: 'tax', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Enter promo code`
  String get promoCodeHint {
    return Intl.message(
      'Enter promo code',
      name: 'promoCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get placeOrder {
    return Intl.message('Place Order', name: 'placeOrder', desc: '', args: []);
  }

  /// `By placing this order, you agree to the terms & conditions.`
  String get placeOrderAgreement {
    return Intl.message(
      'By placing this order, you agree to the terms & conditions.',
      name: 'placeOrderAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Your information is protected and safe. We do not store your bank data.`
  String get secureInfo {
    return Intl.message(
      'Your information is protected and safe. We do not store your bank data.',
      name: 'secureInfo',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty.`
  String get cartEmptyError {
    return Intl.message(
      'Your cart is empty.',
      name: 'cartEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full name.`
  String get nameRequiredError {
    return Intl.message(
      'Please enter your full name.',
      name: 'nameRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your address for delivery.`
  String get addressRequiredError {
    return Intl.message(
      'Please enter your address for delivery.',
      name: 'addressRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number.`
  String get phoneRequiredError {
    return Intl.message(
      'Please enter your phone number.',
      name: 'phoneRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `User not found.`
  String get userNotFoundError {
    return Intl.message(
      'User not found.',
      name: 'userNotFoundError',
      desc: '',
      args: [],
    );
  }

  /// `Order placed successfully! Order number: {orderNumber}`
  String orderSuccess(Object orderNumber) {
    return Intl.message(
      'Order placed successfully! Order number: $orderNumber',
      name: 'orderSuccess',
      desc: '',
      args: [orderNumber],
    );
  }

  /// `Failed to place order: {error}`
  String orderFailed(Object error) {
    return Intl.message(
      'Failed to place order: $error',
      name: 'orderFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Delete Product`
  String get deleteProduct {
    return Intl.message(
      'Delete Product',
      name: 'deleteProduct',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this item from the cart?`
  String get deleteProductConfirm {
    return Intl.message(
      'Are you sure you want to delete this item from the cart?',
      name: 'deleteProductConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Clear Cart`
  String get clearCart {
    return Intl.message('Clear Cart', name: 'clearCart', desc: '', args: []);
  }

  /// `Are you sure you want to remove all items from the cart?`
  String get clearCartConfirm {
    return Intl.message(
      'Are you sure you want to remove all items from the cart?',
      name: 'clearCartConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Clear All`
  String get clearAll {
    return Intl.message('Clear All', name: 'clearAll', desc: '', args: []);
  }

  /// `Search products...`
  String get SearchProducts {
    return Intl.message(
      'Search products...',
      name: 'SearchProducts',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
