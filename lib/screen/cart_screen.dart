import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'account_screen.dart';
import 'category_screen.dart';
import 'home.dart';
import '../provider/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CategoryPage()),
      );
    }

    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AccountPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),

      body: cart.items.isEmpty
          ? const Center(
        child: Text(
          "Cart is empty",
          style: TextStyle(fontSize: 18),
        ),
      )
          : Column(
        children: [

          /// ================= PRODUCT LIST =================
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {

                final item = cart.items[index];

                return Card(
                  margin: const EdgeInsets.all(12),
                  child: ListTile(

                    /// IMAGE
                    leading: Image.asset(
                      item.product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),

                    /// NAME
                    title: Text(item.product.name),

                    /// PRICE × QTY
                    subtitle: Text(
                      "₹ ${item.product.price}  ×  ${item.quantity}",
                    ),

                    /// QUANTITY CONTROLS
                    trailing: SizedBox(
                      width: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cart.decreaseQty(item.product.id);
                            },
                          ),

                          Text(
                            item.quantity.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              cart.increaseQty(item.product.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// ================= TOTAL SECTION =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [

                /// TOTAL PRICE
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "₹ ${cart.totalPrice}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// CHECKOUT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      // Future: Order page
                    },
                    child: const Text("Proceed to Checkout"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      /// ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'account_screen.dart';
// import 'category_screen.dart';
// import 'home.dart';
// import '../provider/cart_provider.dart';
//
// class CartPage extends StatefulWidget {
//   const CartPage({super.key});
//
//   @override
//   State<CartPage> createState() => _CartPageState();
// }
//
// class _CartPageState extends State<CartPage> {
//
//   int _selectedIndex = 3; // Cart selected
//
//   void _onItemTapped(int index) {
//
//     if (index == _selectedIndex) return;
//
//     if (index == 0) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const HomeScreen()),
//       );
//     }
//
//     if (index == 1) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const CategoryPage()),
//       );
//     }
//
//     if (index == 2) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const AccountPage()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     //  LISTEN TO PROVIDER
//     final cart = context.watch<CartProvider>();
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Cart")),
//
//       body: cart.items.isEmpty
//           ? const Center(
//         child: Text(
//           "Cart is empty",
//           style: TextStyle(fontSize: 18),
//         ),
//       )
//           : ListView.builder(
//         itemCount: cart.items.length,
//         itemBuilder: (context, index) {
//
//           final item = cart.items[index];
//
//           return Card(
//             margin: const EdgeInsets.all(12),
//             child: ListTile(
//
//               // 🟢 PRODUCT IMAGE
//               leading: Image.asset(
//                 item.product.image,
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.contain,
//               ),
//
//               // 🟢 PRODUCT NAME
//               title: Text(item.product.name),
//
//               // 🟢 PRODUCT PRICE + QTY TEXT
//               subtitle: Text(
//                 "Qty: ${item.quantity}   |   ₹ ${item.product.price}",
//               ),
//
//               // 🔥 UPDATED TRAILING WITH EDITABLE FIELD
//               trailing: SizedBox(
//                 width: 160,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//
//                     // ➖ DECREASE
//                     IconButton(
//                       icon: const Icon(Icons.remove),
//                       onPressed: () {
//                         cart.decreaseQty(item.product.id);
//                       },
//                     ),
//
//                     // 🔢 EDITABLE QUANTITY BOX
//                     SizedBox(
//                       width: 40,
//                       child: TextFormField(
//                         initialValue: item.quantity.toString(),
//                         textAlign: TextAlign.center,
//                         keyboardType: TextInputType.number,
//                         decoration: const InputDecoration(
//                           isDense: true,
//                           contentPadding: EdgeInsets.symmetric(vertical: 6),
//                           border: OutlineInputBorder(),
//                         ),
//                         onFieldSubmitted: (value) {
//                           final newQty = int.tryParse(value);
//                           if (newQty != null && newQty > 0) {
//                             cart.setQuantity(item.product.id, newQty);
//                           }
//                         },
//                       ),
//                     ),
//
//                     // ➕ INCREASE
//                     IconButton(
//                       icon: const Icon(Icons.add),
//                       onPressed: () {
//                         cart.increaseQty(item.product.id);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//
//
//           // return Card(
//           //   margin: const EdgeInsets.all(12),
//           //   child: ListTile(
//           //
//           //     //  PRODUCT IMAGE
//           //     leading: Image.asset(
//           //       item.product.image,
//           //       width: 50,
//           //       height: 50,
//           //       fit: BoxFit.contain,
//           //     ),
//           //
//           //     //  PRODUCT NAME
//           //     title: Text(item.product.name),
//           //
//           //     //  CLEAN SUBTITLE (NO OVERFLOW)
//           //     subtitle: Text(
//           //       "Qty: ${item.quantity}   |   ₹ ${item.product.price}",
//           //     ),
//           //
//           //     // 🔥 FIXED TRAILING (NO COLUMN NOW)
//           //     trailing: SizedBox(
//           //       width: 120,
//           //       child: Row(
//           //         mainAxisAlignment: MainAxisAlignment.end,
//           //         children: [
//           //
//           //           IconButton(
//           //             icon: const Icon(Icons.remove),
//           //             onPressed: () {
//           //               cart.decreaseQty(item.product.id);
//           //             },
//           //           ),
//           //
//           //           Text("${item.quantity}"),
//           //
//           //           IconButton(
//           //             icon: const Icon(Icons.add),
//           //             onPressed: () {
//           //               cart.increaseQty(item.product.id);
//           //             },
//           //           ),
//           //         ],
//           //       ),
//           //     ),
//           //   ),
//           // );
//         },
//       ),
//
//       // YOUR ORIGINAL BOTTOM NAVIGATION (UNCHANGED)
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Category'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
//           BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
//         ],
//       ),
//     );
//   }
// }





