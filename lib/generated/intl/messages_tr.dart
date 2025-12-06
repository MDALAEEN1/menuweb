// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tr locale. All the
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
  String get localeName => 'tr';

  static String m0(count) => "Alışveriş Sepeti (${count})";

  static String m1(error) => "Sipariş oluşturulamadı: ${error}";

  static String m2(orderNumber) =>
      "Sipariş başarıyla oluşturuldu! Sipariş numarası: ${orderNumber}";

  static String m3(count) => "Ara Toplam (${count})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "BestSellers": MessageLookupByLibrary.simpleMessage("En Çok Satanlar"),
    "SearchProducts": MessageLookupByLibrary.simpleMessage("Ürünlerde ara..."),
    "address": MessageLookupByLibrary.simpleMessage("Adres *"),
    "addressHint": MessageLookupByLibrary.simpleMessage("Tam adresinizi girin"),
    "addressRequiredError": MessageLookupByLibrary.simpleMessage(
      "Teslimat için adresinizi girin.",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("İptal"),
    "cart": MessageLookupByLibrary.simpleMessage("Sepet"),
    "cartClearAll": MessageLookupByLibrary.simpleMessage("Hepsini Temizle"),
    "cartEmptyBrowse": MessageLookupByLibrary.simpleMessage("Ürünlere Göz At"),
    "cartEmptyError": MessageLookupByLibrary.simpleMessage("Sepetiniz boş."),
    "cartEmptySubtitle": MessageLookupByLibrary.simpleMessage(
      "Burada görmek için ürün ekleyin.",
    ),
    "cartEmptyTitle": MessageLookupByLibrary.simpleMessage("Sepetiniz boş"),
    "cartTitle": m0,
    "checkoutTitle": MessageLookupByLibrary.simpleMessage("Ödeme"),
    "clearAll": MessageLookupByLibrary.simpleMessage("Tümünü Temizle"),
    "clearCart": MessageLookupByLibrary.simpleMessage("Sepeti Temizle"),
    "clearCartConfirm": MessageLookupByLibrary.simpleMessage(
      "Sepetteki tüm ürünleri silmek istediğinizden emin misiniz?",
    ),
    "customerInfo": MessageLookupByLibrary.simpleMessage("Müşteri Bilgileri"),
    "delete": MessageLookupByLibrary.simpleMessage("Sil"),
    "deleteProduct": MessageLookupByLibrary.simpleMessage("Ürünü Sil"),
    "deleteProductConfirm": MessageLookupByLibrary.simpleMessage(
      "Bu ürünü sepetten silmek istediğinizden emin misiniz?",
    ),
    "delivery": MessageLookupByLibrary.simpleMessage("Teslimat"),
    "deliveryMethod": MessageLookupByLibrary.simpleMessage("Teslimat Yöntemi"),
    "deliverySubtitle": MessageLookupByLibrary.simpleMessage(
      "Adresinize teslim edilir",
    ),
    "footerBrandDescription": MessageLookupByLibrary.simpleMessage(
      "Sorunsuz bir alışveriş deneyimi için güvenilir adresiniz.",
    ),
    "footerBrandName": MessageLookupByLibrary.simpleMessage("Mağaza Logosu"),
    "footerFollowUs": MessageLookupByLibrary.simpleMessage("Bizi Takip Edin"),
    "footerRights": MessageLookupByLibrary.simpleMessage(
      "© 2024 Mağaza Logosu. Tüm Hakları Saklıdır.",
    ),
    "fullName": MessageLookupByLibrary.simpleMessage("Tam Ad *"),
    "fullNameHint": MessageLookupByLibrary.simpleMessage("Tam adınızı girin"),
    "heroButton": MessageLookupByLibrary.simpleMessage("Şimdi Alışveriş Yap"),
    "heroSubtitle": MessageLookupByLibrary.simpleMessage(
      "Her zevke ve ihtiyaca uygun kaliteli ürünlerden oluşan seçkimize göz atın.",
    ),
    "heroTitle": MessageLookupByLibrary.simpleMessage(
      "Kendinize Özel Tarzı\nKeşfedin",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Menü"),
    "nameRequiredError": MessageLookupByLibrary.simpleMessage(
      "Lütfen tam adınızı girin.",
    ),
    "newArrivals": MessageLookupByLibrary.simpleMessage("Yeni Gelenler"),
    "notes": MessageLookupByLibrary.simpleMessage("Ek Notlar"),
    "notesExample": MessageLookupByLibrary.simpleMessage(
      "Örneğin: Kapıya bırakın, teslimattan önce arayın vb.",
    ),
    "notesHint": MessageLookupByLibrary.simpleMessage(
      "Siparişiniz için özel talimatlar (isteğe bağlı)",
    ),
    "orderFailed": m1,
    "orderSuccess": m2,
    "orderSummary": MessageLookupByLibrary.simpleMessage("Sipariş Özeti"),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Telefon Numarası *"),
    "phoneNumberHint": MessageLookupByLibrary.simpleMessage(
      "+90 5XX XXX XX XX",
    ),
    "phoneRequiredError": MessageLookupByLibrary.simpleMessage(
      "Lütfen telefon numaranızı girin.",
    ),
    "pickup": MessageLookupByLibrary.simpleMessage("Mağazadan Teslim"),
    "pickupSubtitle": MessageLookupByLibrary.simpleMessage(
      "Mağazadan teslim alın",
    ),
    "placeOrder": MessageLookupByLibrary.simpleMessage("Siparişi Tamamla"),
    "placeOrderAgreement": MessageLookupByLibrary.simpleMessage(
      "Bu siparişi vererek şartlar ve koşulları kabul etmiş olursunuz.",
    ),
    "productAddOns": MessageLookupByLibrary.simpleMessage("Ek Ürünler"),
    "productAddToCart": MessageLookupByLibrary.simpleMessage("Sepete Ekle"),
    "productYouMightAlsoLike": MessageLookupByLibrary.simpleMessage(
      "Bunları da Beğenebilirsiniz",
    ),
    "promoCodeHint": MessageLookupByLibrary.simpleMessage(
      "Promosyon kodu girin",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Ara"),
    "searchHint": MessageLookupByLibrary.simpleMessage("Ürünlerde ara..."),
    "secureInfo": MessageLookupByLibrary.simpleMessage(
      "Bilgileriniz korunmaktadır. Banka verilerinizi saklamıyoruz.",
    ),
    "shipping": MessageLookupByLibrary.simpleMessage("Kargo Ücreti"),
    "shopByCategory": MessageLookupByLibrary.simpleMessage(
      "Kategoriye Göre Alışveriş",
    ),
    "subtotal": MessageLookupByLibrary.simpleMessage("Ara Toplam"),
    "summaryCheckout": MessageLookupByLibrary.simpleMessage("Ödeme"),
    "summaryNote": MessageLookupByLibrary.simpleMessage(
      "Kargo ve vergiler ödeme aşamasında hesaplanacaktır.",
    ),
    "summaryShipping": MessageLookupByLibrary.simpleMessage("Kargo Ücreti"),
    "summarySubtotal": m3,
    "summaryTax": MessageLookupByLibrary.simpleMessage("Vergi"),
    "summaryTitle": MessageLookupByLibrary.simpleMessage("Sipariş Özeti"),
    "summaryTotal": MessageLookupByLibrary.simpleMessage("Toplam"),
    "tax": MessageLookupByLibrary.simpleMessage("Vergi (10%)"),
    "total": MessageLookupByLibrary.simpleMessage("Toplam"),
    "userNotFoundError": MessageLookupByLibrary.simpleMessage(
      "Kullanıcı bulunamadı.",
    ),
    "whyUs": MessageLookupByLibrary.simpleMessage("Neden Biz?"),
  };
}
