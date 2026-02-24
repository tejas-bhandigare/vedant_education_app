import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../provider/cart_provider.dart';
import 'cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<ProductDetailsScreen> {

  int quantity = 1;

  void addToCart() {

    // ✅ Use Provider instead of CartPage.cartItems
    final cart = context.read<CartProvider>();

    cart.addProduct(widget.product, quantity);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CartPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE
            Center(
              child: Image.asset(
                product.image,
                height: 220,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),

            /// NAME
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            /// PRICE
            Text(
              "₹ ${product.price}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            /// DESCRIPTION
            Text(
              product.description,
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 20),

            /// QUANTITY SELECTOR
            Row(
              children: [
                const Text(
                  "Quantity:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 15),

                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),

                Text(
                  quantity.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),

            const Spacer(),

            /// ADD TO CART BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: addToCart,
                child: const Text("Add To Cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import '../models/product_model.dart';
// import 'cart_screen.dart';
//
// class ProductDetailsScreen extends StatefulWidget {
//   final Product product;
//
//   const ProductDetailsScreen({
//     super.key,
//     required this.product,
//   });
//
//   @override
//   State<ProductDetailsScreen> createState() =>
//       _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState
//     extends State<ProductDetailsScreen> {
//
//   int quantity = 1;
//
//   void addToCart() {
//
//     /// Check if product already exists in cart
//     int existingIndex = CartPage.cartItems.indexWhere(
//           (item) => item.id == widget.product.id,
//     );
//
//     if (existingIndex != -1) {
//       /// Update quantity if already added
//       CartPage.cartItems[existingIndex].quantity += quantity;
//     } else {
//       /// Add new product with selected quantity
//       CartPage.cartItems.add(
//         widget.product.copyWith(quantity: quantity),
//       );
//     }
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => const CartPage(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final product = widget.product;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             /// IMAGE
//             Center(
//               child: Image.asset(
//                 product.image,
//                 height: 220,
//                 fit: BoxFit.contain,
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// NAME
//             Text(
//               product.name,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             /// PRICE
//             Text(
//               "₹ ${product.price}",
//               style: const TextStyle(
//                 fontSize: 18,
//                 color: Colors.green,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             /// DESCRIPTION
//             Text(
//               product.description,
//               style: const TextStyle(fontSize: 14),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// QUANTITY SELECTOR
//             Row(
//               children: [
//                 const Text(
//                   "Quantity:",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(width: 15),
//
//                 IconButton(
//                   onPressed: () {
//                     if (quantity > 1) {
//                       setState(() {
//                         quantity--;
//                       });
//                     }
//                   },
//                   icon: const Icon(Icons.remove_circle_outline),
//                 ),
//
//                 Text(
//                   quantity.toString(),
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       quantity++;
//                     });
//                   },
//                   icon: const Icon(Icons.add_circle_outline),
//                 ),
//               ],
//             ),
//
//             const Spacer(),
//
//             /// ADD TO CART BUTTON
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: addToCart,
//                 child: const Text("Add To Cart"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import '../models/product_model.dart';
// import 'cart_screen.dart';
//
// class ProductDetailsScreen extends StatelessWidget {
//   final Product product;
//
//   const ProductDetailsScreen({
//     super.key,
//     required this.product,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             /// IMAGE
//             Center(
//               child: Image.asset(
//                 product.image,
//                 height: 220,
//                 fit: BoxFit.contain,
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// NAME
//             Text(
//               product.name,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             /// PRICE
//             Text(
//               "₹ ${product.price}",
//               style: const TextStyle(
//                 fontSize: 18,
//                 color: Colors.green,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             /// DESCRIPTION
//             Text(
//               product.description,
//               style: const TextStyle(fontSize: 14),
//             ),
//
//             const Spacer(),
//
//             /// ADD TO CART BUTTON
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   CartPage.cartItems.add(product);
//
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const CartPage(),
//                     ),
//                   );
//                 },
//                 child: const Text("Add To Cart"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:vedant_education_app/models/product_model.dart';
// import 'cart_screen.dart';
//
// class ProductDetailsScreen extends StatelessWidget {
//   final Product product;
//
//   const ProductDetailsScreen({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(title: Text(product.name)),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Center(
//               child: Image.asset(product.image, height: 200),
//             ),
//
//             const SizedBox(height: 20),
//
//             Text(product.name,
//                 style: const TextStyle(
//                     fontSize: 20, fontWeight: FontWeight.bold)),
//
//             const SizedBox(height: 10),
//
//             Text("₹ ${product.price}",
//                 style: const TextStyle(
//                     fontSize: 18, color: Colors.blue)),
//
//             const SizedBox(height: 10),
//
//             Text(product.description),
//
//             const Spacer(),
//
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//
//                   CartPage.cartItems.add(product);
//
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const CartPage(),
//                     ),
//                   );
//                 },
//                 child: const Text("Add To Cart"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/product_model.dart';
// import '../provider/cart_provider.dart';
//
// class ProductDetailsPage extends StatelessWidget {
//   final Product product;
//
//   const ProductDetailsPage({
//     super.key,
//     required this.product,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//         centerTitle: true,
//       ),
//
//       /// ADD TO CART BUTTON
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(12),
//         child: ElevatedButton.icon(
//           icon: const Icon(Icons.shopping_cart),
//           label: const Text("Add to Cart"),
//           onPressed: () {
//             context.read<CartProvider>().addToCart(product);
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("${product.name} added to cart")),
//             );
//           },
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             /// IMAGE
//             Container(
//               height: 220,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Image.asset(product.image, fit: BoxFit.contain),
//             ),
//
//             const SizedBox(height: 16),
//
//             /// NAME
//             Text(product.name,
//                 style: const TextStyle(
//                     fontSize: 20, fontWeight: FontWeight.bold)),
//
//             const SizedBox(height: 10),
//
//             /// PRICE
//             Text("₹ ${product.price}",
//                 style: const TextStyle(
//                     fontSize: 18,
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold)),
//
//             const SizedBox(height: 20),
//
//             const Text(
//               "This book includes high quality content designed for students.",
//               style: TextStyle(fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }










// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/product_model.dart';
// import '../provider/cart_provider.dart';
//
// class ProductDetailsPage extends StatelessWidget {
//   final String title;
//   final String productId;
//   final double price;
//
//   const ProductDetailsPage({
//     super.key,
//     required this.title,
//     required this.productId,
//     required this.price,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     // ✅ CREATE PRODUCT OBJECT
//     final product = Product(
//       id: productId,
//       name: title,
//       price: price,
//       image: "assets/image/sakshi.png",
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         centerTitle: true,
//       ),
//
//       // 🔵 ADD TO CART BUTTON
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(12),
//         child: ElevatedButton(
//           onPressed: () {
//             print("🔥 ADD TO CART CLICKED");
//
//             // ✅ SEND TO PROVIDER
//             context.read<CartProvider>().addToCart(product);
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Added to Cart")),
//             );
//           },
//           child: const Text("Add to Cart"),
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Container(
//               height: 200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Image.asset(
//                 "assets/image/sakshi.png",
//                 fit: BoxFit.contain,
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             Text(
//               "₹$price",
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             const Text(
//               "This is the product description. Books included with preview only option.",
//             ),
//
//             const SizedBox(height: 16),
//
//             bookRow(context, "Book 1"),
//             bookRow(context, "Book 2"),
//             bookRow(context, "Book 3"),
//             bookRow(context, "Book 4"),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget bookRow(BuildContext context, String title) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Image.asset("assets/image/sakshi.png", height: 50, width: 50),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(title,
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           OutlinedButton(
//             onPressed: () => showPdfPreview(context),
//             child: const Text("Preview only"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void showPdfPreview(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return const Dialog(
//           child: SizedBox(
//             height: 200,
//             child: Center(child: Text("PDF Preview Here")),
//           ),
//         );
//       },
//     );
//   }
// }














// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/cart_provider.dart';
// import '../models/product_model.dart';
//
// class ProductDetailsPage extends StatelessWidget {
//   final Product product;
//
//   const ProductDetailsPage({
//     super.key,
//     required this.product,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//         centerTitle: true,
//       ),
//
//       // 🛒 ADD TO CART BUTTON
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(12),
//         child: ElevatedButton.icon(
//           icon: const Icon(Icons.shopping_cart),
//           label: const Text("Add to Cart"),
//           onPressed: () {
//             // 🔥 ADD PRODUCT TO CART PROVIDER
//             context.read<CartProvider>().addToCart(product);
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text("${product.name} added to cart"),
//               ),
//             );
//           },
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             // 🖼 PRODUCT IMAGE
//             Container(
//               height: 220,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.asset(
//                   product.image,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // 📦 PRODUCT NAME
//             Text(
//               product.name,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             // 💰 PRICE
//             Text(
//               "₹ ${product.price}",
//               style: const TextStyle(
//                 fontSize: 18,
//                 color: Colors.green,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // 📝 DESCRIPTION
//             const Text(
//               "This product includes high-quality study materials designed for students. You can preview books before purchase.",
//               style: TextStyle(fontSize: 14),
//             ),
//
//             const SizedBox(height: 20),
//
//             const Text(
//               "Included Books",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             // 📚 SAMPLE LIST
//             _bookRow(context, "Book 1"),
//             _bookRow(context, "Book 2"),
//             _bookRow(context, "Book 3"),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // 📄 BOOK ROW WIDGET
//   Widget _bookRow(BuildContext context, String title) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Image.asset(
//             product.image,
//             height: 50,
//             width: 50,
//             fit: BoxFit.contain,
//           ),
//
//           const SizedBox(width: 10),
//
//           Expanded(
//             child: Text(
//               title,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//
//           OutlinedButton(
//             onPressed: () {
//               _showPreview(context);
//             },
//             child: const Text("Preview"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 📖 PREVIEW POPUP
//   void _showPreview(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (_) => Dialog(
//         child: SizedBox(
//           height: 300,
//           child: Column(
//             children: [
//
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 color: Colors.grey.shade200,
//                 child: Row(
//                   children: [
//                     const Expanded(
//                       child: Text(
//                         "Preview",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     )
//                   ],
//                 ),
//               ),
//
//               const Expanded(
//                 child: Center(
//                   child: Text("PDF Preview Here"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



















// import 'package:flutter/material.dart';
// import '../service/order_service.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ProductDetailsPage(
//         title: "Sample Product",
//         productId: "demo123",   // 🔥 temporary demo id
//         price: 749,             // 🔥 temporary demo price
//       ),
//     );
//   }
// }
//
// class ProductDetailsPage extends StatelessWidget {
//   // ✅ SERVICE OBJECT (ADD HERE)
//   final CartService cartService = CartService();
//
//   // ✅ REQUIRED VARIABLES
//   final String title;
//   final String productId;
//   final double price;
//
//    ProductDetailsPage({
//     super.key,
//     required this.title,
//     required this.productId,
//     required this.price,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         centerTitle: true,
//       ),
//
//       // 🔵 ADD TO CART BUTTON (MAIN BUTTON)
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(12),
//         child: ElevatedButton(
//           onPressed: () async {
//
//             print("🔥 ADD TO CART CLICKED");
//
//             await cartService.addToCart(
//               productId: productId,
//               price: price,
//             );
//
//             print("🔥 ADD TO CART FUNCTION FINISHED");
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Added to Cart")),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(vertical: 14),
//           ),
//           child: const Text("Add to Cart"),
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // PRODUCT IMAGE
//             Container(
//               height: 200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Image.asset(
//                 "assets/image/sakshi.png",
//                 fit: BoxFit.contain,
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             // PRICE
//             const Text(
//               "55% OFF 1699 ₹749",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             // DESCRIPTION
//             const Text(
//               "This is the product description. Books included with preview only option.",
//               style: TextStyle(fontSize: 14),
//             ),
//
//             const SizedBox(height: 16),
//
//             // BOOK LIST
//             bookRow(context, "Book 1"),
//             bookRow(context, "Book 2"),
//             bookRow(context, "Book 3"),
//             bookRow(context, "Book 4"),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // BOOK ROW
//   Widget bookRow(BuildContext context, String title) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Image.asset(
//             "assets/image/sakshi.png",
//             height: 50,
//             width: 50,
//             fit: BoxFit.contain,
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               title,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           OutlinedButton(
//             onPressed: () => showPdfPreview(context),
//             child: const Text("Preview only"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // PDF POPUP
//   void showPdfPreview(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) {
//         return Dialog(
//           insetPadding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 color: Colors.grey.shade200,
//                 child: Row(
//                   children: [
//                     const Expanded(
//                       child: Text(
//                         "Product Details",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     )
//                   ],
//                 ),
//               ),
//               const Expanded(
//                 child: Center(
//                   child: Text(
//                     "PDF Preview Here",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import '../service/order_service.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ProductDetailsPage(title: '',),
//     );
//   }
// }
//
// class ProductDetailsPage extends StatelessWidget {
//
//
//   const ProductDetailsPage({super.key, required String title});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Product Details"),
//         centerTitle: true,
//       ),
//
//       // FOOTER
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(12),
//         child: ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(vertical: 14),
//           ),
//           child: const Text("Add to Cart"),
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // PRODUCT IMAGE
//             Container(
//               height:200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Image.asset(
//                 "assets/image/sakshi.png",
//                 fit: BoxFit.contain,
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             // PRICE
//             const Text(
//               "55% OFF 1699 ₹749",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             // DESCRIPTION
//             const Text(
//               "This is the product description. Books included with preview only option.",
//               style: TextStyle(fontSize: 14),
//             ),
//
//             const SizedBox(height: 16),
//
//             // BOOK LIST
//             bookRow(context, "Book 1"),
//             bookRow(context, "Book 2"),
//             bookRow(context, "Book 3"),
//             bookRow(context, "Book 4"),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // BOOK ROW
//   Widget bookRow(BuildContext context, String title) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           // IMAGE
//           Image.asset(
//             "assets/image/sakshi.png",
//             height: 50,
//             width: 50,
//             fit: BoxFit.contain,
//           ),
//
//           const SizedBox(width: 10),
//
//           // TITLE
//           Expanded(
//             child: Text(
//               title,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//
//           // PREVIEW BUTTON
//           OutlinedButton(
//             onPressed: () => showPdfPreview(context),
//             child: const Text("Preview only"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // PDF POPUP
//   void showPdfPreview(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) {
//         return Dialog(
//           insetPadding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               // HEADER WITH CLOSE
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 color: Colors.grey.shade200,
//                 child: Row(
//                   children: [
//                     const Expanded(
//                       child: Text(
//                         "Product Details",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     )
//                   ],
//                 ),
//               ),
//
//               // PDF AREA
//               Expanded(
//                 child: Center(
//                   child: Container(
//                     margin: const EdgeInsets.all(16),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "PDF Preview Here",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//
//               // FOOTER BUTTON
//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child:ElevatedButton(
//                   onPressed: () async {
//                     await cartService.addToCart(
//                       productId: product.id,
//                       price: product.price,
//                     );
//
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Added to Cart")),
//                     );
//                   },
//                   child: const Text("Add to Cart"),
//                 )
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }