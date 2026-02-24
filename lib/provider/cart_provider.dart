import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  /// ================= ADD PRODUCT (UPDATED) =================
  void addProduct(Product product, int quantity) {

    final index =
    _items.indexWhere((e) => e.product.id == product.id);

    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          product: product,
          quantity: quantity,
        ),
      );
    }

    saveCart();
    notifyListeners();
  }

  /// ================= REMOVE =================
  void removeItem(String id) {
    _items.removeWhere((e) => e.product.id == id);
    saveCart();
    notifyListeners();
  }

  /// ================= INCREASE =================
  void increaseQty(String id) {
    final index =
    _items.indexWhere((e) => e.product.id == id);

    if (index != -1) {
      _items[index].quantity++;
      saveCart();
      notifyListeners();
    }
  }

  /// ================= DECREASE =================
  void decreaseQty(String id) {
    final index =
    _items.indexWhere((e) => e.product.id == id);

    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      saveCart();
      notifyListeners();
    }
  }

  /// ================= SET QUANTITY =================
  void setQuantity(String productId, int qty) {
    final index =
    _items.indexWhere((e) => e.product.id == productId);

    if (index != -1 && qty > 0) {
      _items[index].quantity = qty;
      saveCart();
      notifyListeners();
    }
  }

  /// ================= TOTAL =================
  double get totalPrice {
    double total = 0;
    for (var e in _items) {
      total += e.product.price * e.quantity;
    }
    return total;
  }

  /// ================= SAVE CART =================
  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();

    final data =
    _items.map((e) => e.toMap()).toList();

    prefs.setString('cart', jsonEncode(data));
  }

  /// ================= LOAD CART =================
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('cart');

    if (data != null) {
      final decoded = jsonDecode(data);

      _items.clear();

      for (var item in decoded) {
        _items.add(CartItem.fromMap(item));
      }

      notifyListeners();
    }
  }

  /// ================= CLEAR =================
  Future<void> clearCart() async {
    _items.clear();

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('cart');

    notifyListeners();
  }
}





// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/cart_model.dart';
// import '../models/product_model.dart';
//
// class CartProvider extends ChangeNotifier {
//
//   final List<CartItem> _items = [];
//
//   List<CartItem> get items => _items;
//
//   // ✅ ADD TO CART
//   void addToCart(Product product) {
//     final index =
//     _items.indexWhere((e) => e.product.id == product.id);
//
//     if (index >= 0) {
//       _items[index].quantity++;
//     } else {
//       _items.add(CartItem(product: product));
//     }
//
//     saveCart();
//     notifyListeners();
//   }
//
//   // ✅ REMOVE
//   void removeItem(String id) {
//     _items.removeWhere((e) => e.product.id == id);
//     saveCart();
//     notifyListeners();
//   }
//
//   // ✅ INCREASE
//   void increaseQty(String id) {
//     final item = _items.firstWhere((e) => e.product.id == id);
//     item.quantity++;
//     saveCart();
//     notifyListeners();
//   }
//
//   // ✅ DECREASE
//   void decreaseQty(String id) {
//     final item = _items.firstWhere((e) => e.product.id == id);
//     if (item.quantity > 1) {
//       item.quantity--;
//     }
//     saveCart();
//     notifyListeners();
//   }
//
//   // ✅ TOTAL
//   double get totalPrice {
//     double total = 0;
//     for (var e in _items) {
//       total += e.product.price * e.quantity;
//     }
//     return total;
//   }
//
//   // ===============================
//   // 🔥 PERSISTENT CART LOGIC
//   // ===============================
//
//   Future<void> saveCart() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     final data =
//     _items.map((e) => e.toMap()).toList();
//
//     prefs.setString('cart', jsonEncode(data));
//   }
//
//   Future<void> loadCart() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     final data = prefs.getString('cart');
//
//     if (data != null) {
//       final decoded = jsonDecode(data);
//
//       _items.clear();
//
//       for (var item in decoded) {
//         _items.add(CartItem.fromMap(item));
//       }
//
//       notifyListeners();
//     }
//   }
//
//   void setQuantity(String productId, int qty) {
//     final index = _items.indexWhere((e) => e.product.id == productId);
//     if (index != -1) {
//       _items[index].quantity = qty;
//       notifyListeners();
//     }
//   }
//
//
//   Future<void> clearCart() async {
//     _items.clear();
//
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove('cart');
//
//     notifyListeners();
//   }
// }
//
