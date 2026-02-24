import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/product_model.dart';
import 'product_details.dart';

class ProductListScreen extends StatelessWidget {
  final String category;
  final String subCategory;

  const ProductListScreen({
    super.key,
    required this.category,
    required this.subCategory,
  });

  @override
  Widget build(BuildContext context) {

    List<Product> products = allProducts.where(
          (p) =>
      p.category == category &&
          p.subCategory == subCategory,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(subCategory),
        centerTitle: true,
      ),
      body: products.isEmpty
          ? const Center(child: Text("No Products Available"))
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProductDetailsScreen(product: product),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹ ${product.price}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}