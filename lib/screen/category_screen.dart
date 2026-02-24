import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/product_model.dart';
import 'product_list.dart';
// import 'books_list_screen.dart';
import 'account_screen.dart';
import 'cart_screen.dart';
import 'home.dart';

class CategoryPage extends StatefulWidget {
  final String? selectedCategory;

  const CategoryPage({super.key, this.selectedCategory});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectedIndex = 1;
  int selectedCategoryIndex = 0;

  final List<String> categories = [
    "Bag",
    "Books",
    "Certificate",
    "Uniform",
  ];

  @override
  void initState() {
    super.initState();
    if (widget.selectedCategory != null) {
      final index = categories.indexOf(widget.selectedCategory!);
      if (index != -1) selectedCategoryIndex = index;
    }
  }

  /// ================= BOTTOM NAV =================
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
    if (index == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const AccountPage()));
    }
    if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const CartPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vedant Education"),
        centerTitle: true,
      ),
      body: Row(
        children: [

          /// ================= LEFT CATEGORY MENU =================
          Container(
            width: 120,
            color: Colors.grey.shade200,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => setState(() => selectedCategoryIndex = index),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: selectedCategoryIndex == index
                        ? Colors.white
                        : Colors.grey.shade200,
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontWeight: selectedCategoryIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// ================= RIGHT CONTENT =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: rightContent(),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        ],
      ),
    );
  }

  /// ================= RIGHT PANEL SWITCH =================
  Widget rightContent() {
    String selected = categories[selectedCategoryIndex];

    if (selected == "Books") {
      return booksUI();
    }

    /// Get dynamic subcategories from product_data
    List<String> subCategories = allProducts
        .where((p) => p.category == selected)
        .map((p) => p.subCategory)
        .toSet()
        .toList();

    if (subCategories.isEmpty) {
      return Center(child: Text("No $selected Available"));
    }

    return GridView.builder(
      itemCount: subCategories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductListScreen(
                  category: selected,
                  subCategory: subCategories[index],
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Center(
              child: Text(
                subCategories[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// ================= BOOKS UI (UNCHANGED) =================
  Widget booksUI() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SectionTitle("Play Group"),
          Row(children: [
            ContentBox(
              title: "Merged Books",
              onTap: () => openBooks("Merged"),
            ),
            ContentBox(
              title: "Subject Wise",
              onTap: () => openBooks("Subject"),
            ),
          ]),

          const SectionTitle("Nursery"),
          Row(children: [
            ContentBox(
              title: "Nursery",
              onTap: () => openBooks("Nursery"),
            ),
            ContentBox(
              title: "Subject Wise",
              onTap: () => openBooks("Subject"),
            ),
          ]),

          const SectionTitle("Junior"),
          Row(children: [
            ContentBox(
              title: "Junior",
              onTap: () => openBooks("Junior"),
            ),
            ContentBox(
              title: "Subject Wise",
              onTap: () => openBooks("Subject"),
            ),
          ]),
        ],
      ),
    );
  }

  void openBooks(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductListScreen(category: category, subCategory: '',),
      ),
    );
  }
}

/// ================= REUSABLE WIDGETS =================
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ContentBox extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const ContentBox({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 120,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:vedant_education_app/screen/product_details.dart';
// import 'account_screen.dart';
// import 'cart_screen.dart';
// import 'home.dart';
//
// class CategoryPage extends StatefulWidget {
//   final String? selectedCategory;
//
//   const CategoryPage({
//     super.key,
//     this.selectedCategory,
//   });
//
//
//   // const CategoryPage({super.key});
//
//   @override
//   State<CategoryPage> createState() => _CategoryPageState();
// }
//
// class _CategoryPageState extends State<CategoryPage> {
//   int _selectedIndex = 1;
//   int selectedCategoryIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//
//     if (widget.selectedCategory != null) {
//       final index = categories.indexOf(widget.selectedCategory!);
//       if (index != -1) {
//         selectedCategoryIndex = index;
//       }
//     }
//   }
//
//
//   final List<String> categories = [
//     "Bag",
//     "Books",
//     "Certificate",
//     "Id Card",
//     "Medals",
//     "Notebooks",
//     "Progress Card",
//     "Results",
//     "Papers",
//     "Uniform",
//   ];
//
//   /// ================= BOTTOM NAVIGATION =================
//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);
//
//     if (index == 0) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const HomeScreen()),
//       );
//     } else if (index == 2) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const AccountPage()),
//       );
//     } else if (index == 3) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const CartPage()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Vedant Education"),
//         centerTitle: true,
//       ),
//
//       /// ================= BODY =================
//       body: Row(
//         children: [
//           /// ===== LEFT CATEGORY LIST =====
//           Container(
//             width: 120,
//             color: Colors.grey.shade200,
//             child: ListView.builder(
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () => setState(() => selectedCategoryIndex = index),
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     color: selectedCategoryIndex == index
//                         ? Colors.white
//                         : Colors.grey.shade200,
//                     child: Text(
//                       categories[index],
//                       style: TextStyle(
//                         fontWeight: selectedCategoryIndex == index
//                             ? FontWeight.bold
//                             : FontWeight.normal,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           /// ===== RIGHT CONTENT =====
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: rightContent(),
//             ),
//           ),
//         ],
//       ),
//
//       /// ===== BOTTOM NAV =====
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
//
//   /// ================= RIGHT SWITCH =================
//   Widget rightContent() {
//     final selected = categories[selectedCategoryIndex];
//
//     switch (selected) {
//       case "Bag":
//         return bagUI();
//       case "Books":
//         return booksUI();
//       case "Certificate":
//         return certificateUI();
//       case "Id Card":
//         return idCardUI();
//       case "Medals":
//         return medalsUI();
//       case "Notebooks":
//         return notebooksUI();
//       case "Progress Card":
//         return progressCardUI();
//       case "Papers":
//         return samplePapersUI();
//       case "Uniform":
//         return uniformsUI();
//       default:
//         return Center(
//           child: Text(
//             selected,
//             style: const TextStyle(fontSize: 18),
//           ),
//         );
//     }
//   }
//   /// ================= BAG UI =================
//   Widget bagUI() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           SectionTitle("Bags"),
//           Row(children: [
//             ContentBox(title: "Bag 1", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Bag 2", imagePath: "assets/image/sakshi.png"),
//           ]),
//           Row(children: [
//             ContentBox(title: "Bag 3", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Bag 4", imagePath: "assets/image/sakshi.png"),
//           ]),
//           Row(children: [
//             ContentBox(title: "Bag 5", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Bag 6", imagePath: "assets/image/sakshi.png"),
//           ]),
//           Row(children: [
//             ContentBox(title: "Bag 7", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Bag 8", imagePath: "assets/image/sakshi.png"),
//           ]),
//           Row(children: [
//             ContentBox(title: "Bag 9", imagePath: "assets/image/sakshi.png"),
//             Spacer(),
//           ]),
//         ],
//       ),
//     );
//   }
//   /// ================= BOOKS UI =================
//   Widget booksUI() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SectionTitle("Play Group"),
//           Row(children: [
//             ContentBox(
//               title: "Merged Books",
//               imagePath: "assets/image/sakshi.png",
//               onTap: () => openBook("Merged Books"),
//             ),
//             ContentBox(title: "Subject Wise", imagePath: "assets/image/sakshi.png"),
//           ]),
//           const SectionTitle("Nursery"),
//           const Row(children: [
//             ContentBox(title: "Merged", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Subject Wise", imagePath: "assets/image/sakshi.png"),
//           ]),
//           const SectionTitle("Junior"),
//           const Row(children: [
//             ContentBox(title: "Merged", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Subject Wise", imagePath: "assets/image/sakshi.png"),
//           ]),
//           const SectionTitle("Senior"),
//           const Row(children: [
//             ContentBox(title: "Subject Wise", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Merged", imagePath: "assets/image/sakshi.png"),
//           ]),
//           const Row(children: [
//             ContentBox(title: "Senior KG Worksheet", imagePath: "assets/image/sakshi.png"),
//             Spacer(),
//           ]),
//           const SectionTitle("English Cursive"),
//           const Row(children: [
//             ContentBox(title: "Level 1", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Level 2", imagePath: "assets/image/sakshi.png"),
//           ]),
//           //मराठी भाषा
//           const SectionTitle("मराठी भाषा"),
//           Row(
//             children: [
//               ContentBox(
//                 title: "मराठी Nursery Book",
//                 imagePath: "assets/image/sakshi.png",
//               ),
//               ContentBox(
//                 title: "मराठी Junior Kg Book",
//                 imagePath: "assets/image/sakshi.png",
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//   void openBook(String title) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => ProductDetailsPage(
//           title: title,
//           productId: title, // 🔥 temporary unique id (later from DB)
//           price: 749,       // 🔥 temporary price
//         ),
//       ),
//     );
//   }
//
//
//   /// ================= CERTIFICATE UI =================
//   Widget certificateUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SectionTitle("Certificates"),
//         Row(children: [
//           ContentBox(title: "Certificate 1", imagePath: "assets/image/sakshi.png"),
//           ContentBox(title: "Certificate 2", imagePath: "assets/image/sakshi.png"),
//         ]),
//         Row(children: [
//           ContentBox(title: "Certificate 3", imagePath: "assets/image/sakshi.png"),
//           ContentBox(title: "Certificate 4", imagePath: "assets/image/sakshi.png"),
//         ]),
//       ],
//     );
//   }
//
//   Widget idCardUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SectionTitle("Id Card"),
//         Row(children: [
//           ContentBox(title: "Id Card 1", imagePath: "assets/image/sakshi.png"),
//           ContentBox(title: "Id Card 2", imagePath: "assets/image/sakshi.png"),
//         ]),
//       ],
//     );
//   }
//
//   Widget medalsUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SectionTitle("Medals"),
//         Row(children: [
//           ContentBox(title: "Gold Silver Bronze", imagePath: "assets/image/sakshi.png"),
//           Spacer(),
//         ]),
//       ],
//     );
//   }
//
//   Widget notebooksUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SectionTitle("Notebook"),
//         Row(children: [
//           ContentBox(title: "Notebook 1", imagePath: "assets/image/sakshi.png"),
//           ContentBox(title: "Notebook 2", imagePath: "assets/image/sakshi.png"),
//         ]),
//         Row(children: [
//           ContentBox(title: "Notebook 3", imagePath: "assets/image/sakshi.png"),
//           Spacer(),
//         ]),
//       ],
//     );
//   }
//
//   Widget progressCardUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SectionTitle("Progress Card"),
//         Row(children: [
//           ContentBox(title: "Progress Card 1", imagePath: "assets/image/sakshi.png"),
//           ContentBox(title: "Progress Card 2", imagePath: "assets/image/sakshi.png"),
//         ]),
//         Row(children: [
//           ContentBox(title: "Progress Card 3", imagePath: "assets/image/sakshi.png"),
//           ContentBox(title: "Result", imagePath: "assets/image/sakshi.png"),
//         ]),
//       ],
//     );
//   }
//
//
//   // sample paper
//
//   Widget samplePapersUI() {
//     // 🔹 clickable item (merged here)
//     Widget clickableItem(String title) {
//       return ListTile(
//         title: Text(title),
//         onTap: () => print("$title clicked"),
//       );
//     }
//     // 🔹 expandable section
//     Widget section(String title) {
//       return Container(
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: ExpansionTile(
//           title: Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           children: [
//             clickableItem("Unit 1"),
//             clickableItem("Test 1"),
//             clickableItem("Unit 2"),
//             clickableItem("Test 2"),
//           ],
//         ),
//       );
//     }
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SectionTitle("Sample Papers"),
//           section("Play Group"),
//           section("Junior"),
//           section("Nursery"),
//           section("Senior"),
//         ],
//       ),
//     );
//   }
//
//
//
//   Widget uniformsUI() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           SectionTitle("Uniform"),
//           Row(children: [
//             ContentBox(title: "Uniform 1", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Uniform 2", imagePath: "assets/image/sakshi.png"),
//           ]),
//           Row(children: [
//             ContentBox(title: "Uniform 3", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Uniform 4", imagePath: "assets/image/sakshi.png"),
//           ]),
//           Row(children: [
//             ContentBox(title: "Uniform 5", imagePath: "assets/image/sakshi.png"),
//             Spacer(),
//           ]),
//         ],
//       ),
//     );
//   }
// }
//
// /// ================= SECTION TITLE =================
// class SectionTitle extends StatelessWidget {
//   final String title;
//   const SectionTitle(this.title, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
//
// /// ================= CONTENT BOX =================
// /// Later you can add:
// /// ElevatedButton(onPressed: addToCart)
// class ContentBox extends StatelessWidget {
//   final String title;
//   final String imagePath;
//   final VoidCallback? onTap;
//
//   const ContentBox({
//     super.key,
//     required this.title,
//     required this.imagePath,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell( // ✅ THIS MAKES IT CLICKABLE
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           height: 170,
//           margin: const EdgeInsets.all(8),
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 imagePath,
//                 height: 80,
//                 width: 80,
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(height: 8),
//               Text(title, textAlign: TextAlign.center),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }













// import 'package:flutter/material.dart';
// import '../models/product_model.dart';
// import 'product_details.dart';
//
// class CategoryPage extends StatefulWidget {
//   final String? selectedCategory;
//
//   const CategoryPage({super.key, this.selectedCategory});
//
//   @override
//   State<CategoryPage> createState() => _CategoryPageState();
// }
//
// class _CategoryPageState extends State<CategoryPage> {
//
//   int selectedCategoryIndex = 0;
//
//   final List<String> categories = [
//     "Bag",
//     "Books",
//     "Certificate",
//     "Id Card",
//     "Medals",
//     "Notebooks",
//     "Progress Card",
//     "Sample Papers",
//     "Uniform",
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (widget.selectedCategory != null) {
//       final index = categories.indexOf(widget.selectedCategory!);
//       if (index != -1) selectedCategoryIndex = index;
//     }
//   }
//
//   /// 🔥 UNIVERSAL PRODUCT NAVIGATION
//   void openProduct(String title) {
//     final product = Product(
//       id: title,
//       name: title,
//       price: 749,
//       image: "assets/image/sakshi.png",
//     );
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => ProductDetailsPage(product: product),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Vedant Education"),
//         centerTitle: true,
//       ),
//
//       body: Row(
//         children: [
//
//           /// LEFT CATEGORY LIST
//           Container(
//             width: 120,
//             color: Colors.grey.shade200,
//             child: ListView.builder(
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () => setState(() => selectedCategoryIndex = index),
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     color: selectedCategoryIndex == index
//                         ? Colors.white
//                         : Colors.grey.shade200,
//                     child: Text(
//                       categories[index],
//                       style: TextStyle(
//                         fontWeight: selectedCategoryIndex == index
//                             ? FontWeight.bold
//                             : FontWeight.normal,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           /// RIGHT CONTENT
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: rightContent(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// SWITCH CONTENT
//   Widget rightContent() {
//     switch (categories[selectedCategoryIndex]) {
//       case "Bag":
//         return simpleGrid(["Bag 1", "Bag 2", "Bag 3"]);
//
//       case "Books":
//         return simpleGrid([
//           "Merged Books",
//           "Subject Wise",
//           "Nursery Book",
//           "Junior Book",
//           "Senior Book"
//         ]);
//
//       case "Certificate":
//         return simpleGrid(["Certificate 1", "Certificate 2"]);
//
//       case "Id Card":
//         return simpleGrid(["ID Card 1", "ID Card 2"]);
//
//       case "Medals":
//         return simpleGrid(["Gold Medal", "Silver Medal"]);
//
//       case "Notebooks":
//         return simpleGrid(["Notebook 1", "Notebook 2"]);
//
//       case "Progress Card":
//         return simpleGrid(["Progress Card", "Result"]);
//
//       case "Sample Papers":
//         return samplePaperUI();
//
//       case "Uniform":
//         return simpleGrid(["Uniform 1", "Uniform 2"]);
//
//       default:
//         return const SizedBox();
//     }
//   }
//
//   /// GRID BUILDER FOR SIMPLE CATEGORIES
//   Widget simpleGrid(List<String> items) {
//     return GridView.builder(
//       itemCount: items.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 12,
//         childAspectRatio: 1,
//       ),
//       itemBuilder: (context, index) {
//         return ContentBox(
//           title: items[index],
//           imagePath: "assets/image/sakshi.png",
//           onTap: () => openProduct(items[index]),
//         );
//       },
//     );
//   }
//
//   /// SAMPLE PAPERS EXPANDABLE UI
//   Widget samplePaperUI() {
//     Widget item(String title) {
//       return ListTile(
//         title: Text(title),
//         onTap: () => openProduct(title),
//       );
//     }
//
//     Widget section(String title) {
//       return Container(
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: ExpansionTile(
//           title: Text(title,
//               style:
//               const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           children: [
//             item("Unit 1"),
//             item("Test 1"),
//             item("Unit 2"),
//             item("Test 2"),
//           ],
//         ),
//       );
//     }
//
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           section("Play Group"),
//           section("Nursery"),
//           section("Junior"),
//           section("Senior"),
//         ],
//       ),
//     );
//   }
// }
//
// /// ================= CONTENT BOX =================
// class ContentBox extends StatelessWidget {
//   final String title;
//   final String imagePath;
//   final VoidCallback? onTap;
//
//   const ContentBox({
//     super.key,
//     required this.title,
//     required this.imagePath,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(imagePath, height: 80),
//             const SizedBox(height: 8),
//             Text(title, textAlign: TextAlign.center),
//           ],
//         ),
//       ),
//     );
//   }
// }





















// import 'package:flutter/material.dart';
// import 'package:vedant_education_app/screen/product_details.dart';
//
// import 'account_screen.dart';
// import 'cart_screen.dart';
// import 'home.dart';
//
// class CategoryPage extends StatefulWidget {
//   const CategoryPage({super.key});
//
//   @override
//   State<CategoryPage> createState() => _CategoryPageState();
// }
//
// class _CategoryPageState extends State<CategoryPage> {
//   int _selectedIndex = 1;
//   int selectedCategoryIndex = 0;
//
//   final List<String> categories = [
//     "Bag",
//     "Books",
//     "Certificate",
//     "Id Card",
//     "Medals",
//     "Notebooks",
//     "Progress Card",
//     "Results",
//     "Sample Papers",
//     "Uniform",
//   ];
//
//   /// ================= BOTTOM NAVIGATION =================
//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);
//
//     if (index == 0) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const HomeScreen()),
//       );
//     } else if (index == 2) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const AccountPage()),
//       );
//     } else if (index == 3) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const CartPage()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Vedant Education"),
//         centerTitle: true,
//       ),
//
//       /// ================= BODY =================
//       body: Row(
//         children: [
//           /// ===== LEFT CATEGORY LIST =====
//           Container(
//             width: 120,
//             color: Colors.grey.shade200,
//             child: ListView.builder(
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () => setState(() => selectedCategoryIndex = index),
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     color: selectedCategoryIndex == index
//                         ? Colors.white
//                         : Colors.grey.shade200,
//                     child: Text(
//                       categories[index],
//                       style: TextStyle(
//                         fontWeight: selectedCategoryIndex == index
//                             ? FontWeight.bold
//                             : FontWeight.normal,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           /// ===== RIGHT CONTENT =====
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: rightContent(),
//             ),
//           ),
//         ],
//       ),
//
//       /// ===== BOTTOM NAV =====
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.purple,
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
//
//   /// ================= RIGHT SWITCH =================
//   Widget rightContent() {
//     final selected = categories[selectedCategoryIndex];
//
//     switch (selected) {
//       case "Bag":
//         return bagUI();
//       case "Books":
//         return booksUI();
//       case "Certificate":
//         return certificateUI();
//       case "Id Card":
//         return idCardUI();
//       case "Medals":
//         return medalsUI();
//       case "Notebooks":
//         return notebooksUI();
//       case "Progress Card":
//         return progressCardUI();
//       case "Uniform":
//         return uniformsUI();
//       default:
//         return Center(
//           child: Text(selected, style: const TextStyle(fontSize: 18)),
//         );
//     }
//   }
//
//   /// ================= BAG UI =================
//   Widget bagUI() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           SectionTitle("Bags"),
//           Row(children: [
//             ContentBox(title: "Bag 1", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Bag 2", imagePath: "assets/image/sakshi.png"),
//           ]),
//         ],
//       ),
//     );
//   }
//
//   /// ================= BOOKS UI (CLICK ENABLED) =================
//   Widget booksUI() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SectionTitle("Play Group"),
//
//           Row(children: [
//             ContentBox(
//               title: "Merged Books",
//               imagePath: "assets/image/sakshi.png",
//               onTap: () => openBook("Merged Books"),
//             ),
//             ContentBox(
//               title: "Subject Wise",
//               imagePath: "assets/image/sakshi.png",
//               onTap: () => openBook("Subject Wise"),
//             ),
//           ]),
//
//           const SectionTitle("Nursery"),
//           Row(children: [
//             ContentBox(
//               title: "Nursery Merged",
//               imagePath: "assets/image/sakshi.png",
//               onTap: () => openBook("Nursery Merged"),
//             ),
//             ContentBox(
//               title: "Nursery Subject Wise",
//               imagePath: "assets/image/sakshi.png",
//               onTap: () => openBook("Nursery Subject Wise"),
//             ),
//           ]),
//         ],
//       ),
//     );
//   }
//
//   void openBook(String title) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => ProductDetailsPage(title: title),
//       ),
//     );
//   }
//
//   /// ================= CERTIFICATE UI =================
//   Widget certificateUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SectionTitle("Certificates"),
//         Row(children: [
//           ContentBox(title: "Certificate 1", imagePath: "assets/image/sakshi.png"),
//           ContentBox(title: "Certificate 2", imagePath: "assets/image/sakshi.png"),
//         ]),
//       ],
//     );
//   }
//
//   Widget idCardUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SectionTitle("Id Card"),
//         Row(children: [
//           ContentBox(title: "Id Card 1", imagePath: "assets/image/sakshi.png"),
//           ContentBox(title: "Id Card 2", imagePath: "assets/image/sakshi.png"),
//         ]),
//       ],
//     );
//   }
//
//   Widget medalsUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SectionTitle("Medals"),
//         Row(children: [
//           ContentBox(title: "Gold Silver Bronze", imagePath: "assets/image/sakshi.png"),
//           Spacer(),
//         ]),
//       ],
//     );
//   }
//
//   Widget notebooksUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SectionTitle("Notebook"),
//         Row(children: [
//           ContentBox(title: "Notebook 1", imagePath: "assets/image/sakshi.png"),
//           ContentBox(title: "Notebook 2", imagePath: "assets/image/sakshi.png"),
//         ]),
//       ],
//     );
//   }
//
//   Widget progressCardUI() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SectionTitle("Progress Card"),
//         Row(children: [
//           ContentBox(title: "Progress Card 1", imagePath: "assets/image/sakshi.png"),
//           ContentBox(title: "Progress Card 2", imagePath: "assets/image/sakshi.png"),
//         ]),
//       ],
//     );
//   }
//
//   Widget uniformsUI() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           SectionTitle("Uniform"),
//           Row(children: [
//             ContentBox(title: "Uniform 1", imagePath: "assets/image/sakshi.png"),
//             ContentBox(title: "Uniform 2", imagePath: "assets/image/sakshi.png"),
//           ]),
//         ],
//       ),
//     );
//   }
// }
//
// /// ================= SECTION TITLE =================
// class SectionTitle extends StatelessWidget {
//   final String title;
//   const SectionTitle(this.title, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
//
// /// ================= CONTENT BOX =================
// class ContentBox extends StatelessWidget {
//   final String title;
//   final String imagePath;
//   final VoidCallback? onTap;
//
//   const ContentBox({
//     super.key,
//     required this.title,
//     required this.imagePath,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           height: 170,
//           margin: const EdgeInsets.all(8),
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 imagePath,
//                 height: 80,
//                 width: 80,
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(height: 8),
//               Text(title, textAlign: TextAlign.center),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// ================= BOOK DETAILS PAGE =================
// class BooksDetailsPage extends StatelessWidget {
//   final String title;
//   const BooksDetailsPage({super.key, required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: Center(
//         child: Text(
//           "You opened $title",
//           style: const TextStyle(fontSize: 22),
//         ),
//       ),
//     );
//   }
// }





