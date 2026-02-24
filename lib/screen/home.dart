import 'dart:async';
import 'package:flutter/material.dart';
import 'account_screen.dart';
import 'cart_screen.dart';
import 'category_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  int _selectedCategoryIcon = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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

    if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CartPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔍 SEARCH
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search books, papers, etc',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //🔥 CATEGORY LIST WITH HIGHLIGHT
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategory(context, Icons.menu_book, "Books", 0),
                    _buildCategory(context, Icons.backpack, "Bags", 1),
                    _buildCategory(context, Icons.checkroom, "Uniforms", 2),
                    _buildCategory(context, Icons.description, "Sample Papers", 3),
                    _buildCategory(context, Icons.more_horiz, "More", 4),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔥 RECOMMENDED SLIDER
              const RecommendedSlider(),

              const SizedBox(height: 20),

              Row(
                children: const [
                  Icon(Icons.arrow_back_ios),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

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

  // 🔥 CATEGORY ICON BUILDER (INSIDE STATE CLASS)
  Widget _buildCategory(
      BuildContext context,
      IconData icon,
      String label,
      int index,
      ) {
    final bool isSelected = _selectedCategoryIcon == index;

    return InkWell(
      onTap: () {

        setState(() {
          _selectedCategoryIcon = index;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryPage(selectedCategory: label),
          ),
        );
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor:
              isSelected ? Colors.blue :Colors.blue.shade50,
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.blue,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔥 RECOMMENDED SLIDER
class RecommendedSlider extends StatefulWidget {
  const RecommendedSlider({super.key});

  @override
  State<RecommendedSlider> createState() => _RecommendedSliderState();
}

class _RecommendedSliderState extends State<RecommendedSlider> {

  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> images = [
    "assets/image/sakshi.png",
    "assets/image/sakshi.png",
    "assets/image/sakshi.png",
    "assets/image/sakshi.png",
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            'Recommended for You',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}









//
// import 'dart:async';
// import 'package:flutter/material.dart';
//
// import 'account_screen.dart';
// import 'cart_screen.dart';
// import 'category_screen.dart';
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
//       title: 'Book Store UI',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   int _selectedIndex = 0;
//   int _selectedCategoryIcon = 0;
//
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
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
//
//     if (index == 3) {
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
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               // 🔍 SEARCH
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search books, papers, etc',
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//
//                const SizedBox(height: 20),
//
//               // CATEGORY LIST
//
//               // SizedBox(
//               //   height: 90,
//               //   child: ListView(
//               //     scrollDirection: Axis.horizontal,
//               //     children: [
//               //
//               //       _buildCategory(context, Icons.menu_book, "Books", 0),
//               //       _buildCategory(context, Icons.backpack, "Bags", 1),
//               //       _buildCategory(context, Icons.checkroom, "Uniforms", 2),
//               //       _buildCategory(context, Icons.description, "Sample Papers", 3),
//               //       _buildCategory(context, Icons.more_horiz, "More", 4),
//               //
//               //     ],
//               //   ),
//               // ),
//
//
//               SizedBox(
//                 height: 80,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//
//                     _buildCategory(context, Icons.menu_book, "Books"),
//                     _buildCategory(context, Icons.backpack, "Bags"),
//                     _buildCategory(context, Icons.checkroom, "Uniforms"),
//                     _buildCategory(context, Icons.description, "Papers"),
//                     _buildCategory(context, Icons.more_horiz, "More"),
//
//                   ],
//                 ),
//               ),
//
//
//
//               // SizedBox(
//               //   height: 90,
//               //   child: ListView(
//               //     scrollDirection: Axis.horizontal,
//               //     children: [
//               //       _buildCategory(Icons.book, "Books"),
//               //       _buildCategory(Icons.backpack_outlined, "Papers"),
//               //       _buildCategory(Icons.menu_book, "Notes"),
//               //       _buildCategory(Icons.video_library, "Videos"),
//               //       _buildCategory(Icons.more_horiz, "More"),
//               //     ],
//               //   ),
//               // ),
//
//               const SizedBox(height: 20),
//
//               // 🔥 UPDATED RECOMMENDED SLIDER
//               const RecommendedSlider(),
//
//               const SizedBox(height: 20),
//
//               Row(
//                 children: const [
//                   Icon(Icons.arrow_back_ios),
//                   Spacer(),
//                   Icon(Icons.arrow_forward_ios),
//                 ],
//               ),
//
//               // const SizedBox(height: 10),
//
//               SizedBox(
//                 height: 120,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       width: 100,
//                       margin: const EdgeInsets.only(right: 12),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//
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
// }
//
// // 🔥 RECOMMENDED SLIDER WIDGET
// class RecommendedSlider extends StatefulWidget {
//   const RecommendedSlider({super.key});
//
//   @override
//   State<RecommendedSlider> createState() => _RecommendedSliderState();
// }
//
// class _RecommendedSliderState extends State<RecommendedSlider> {
//
//   final PageController _controller = PageController();
//   int _currentPage = 0;
//   Timer? _timer;
//
//   final List<String> images = [
//     "assets/image/sakshi.png",
//     "assets/image/sakshi.png",
//     "assets/image/sakshi.png",
//     "assets/image/sakshi.png",
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (_currentPage < images.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//
//       _controller.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 250,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade50,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           const Text(
//             'Recommended for You',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//
//           const SizedBox(height: 10),
//
//           Expanded(
//             child: PageView.builder(
//               controller: _controller,
//               itemCount: images.length,
//               itemBuilder: (context, index) {
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.asset(
//                     images[index],
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // CATEGORY ICON BUILDER
//
// Widget _buildCategory(
//     BuildContext context,
//     IconData icon,
//     String label,
//     int index,
//     ) {
//   final bool isSelected = _selectedCategoryIcon == index;
//
//   return InkWell(
//     onTap: () {
//
//       // 🔥 update selected highlight
//       setState(() {
//         _selectedCategoryIcon = index;
//       });
//
//       // 🔥 navigate to category page
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => CategoryPage(selectedCategory: label),
//         ),
//       );
//     },
//     child: Container(
//       width: 80,
//       margin: const EdgeInsets.only(right: 12),
//       child: Column(
//         children: [
//
//           CircleAvatar(
//             radius: 25,
//             backgroundColor:
//             isSelected ? Colors.purple : Colors.blue.shade50,
//             child: Icon(
//               icon,
//               color: isSelected ? Colors.white : Colors.blue,
//             ),
//           ),
//
//           const SizedBox(height: 6),
//
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight:
//               isSelected ? FontWeight.bold : FontWeight.normal,
//               color: isSelected ? Colors.purple : Colors.black,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
//
// //
// // Widget _buildCategory(BuildContext context, IconData icon, String label) {
// //   return InkWell(
// //     onTap: () {
// //
// //       //  OPEN CATEGORY PAGE WITH SELECTED CATEGORY
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (_) => CategoryPage(
// //             selectedCategory: label,
// //           ),
// //         ),
// //       );
// //     },
// //     child: Container(
// //       width: 80,
// //       margin: const EdgeInsets.only(right: 12),
// //       child: Column(
// //         children: [
// //           CircleAvatar(
// //             radius: 25,
// //             backgroundColor: Colors.blue.shade50,
// //             child: Icon(icon, color: Colors.blue),
// //           ),
// //           const SizedBox(height: 6),
// //           Text(label, style: const TextStyle(fontSize: 12)),
// //         ],
// //       ),
// //     ),
// //   );
// // }
//
//
// // Widget _buildCategory(IconData icon, String label) {
// //   return Container(
// //     width: 80,
// //     margin: const EdgeInsets.only(right: 12),
// //     child: Column(
// //       children: [
// //         CircleAvatar(
// //           radius: 25,
// //           backgroundColor: Colors.blue.shade50,
// //           child: Icon(icon, color: Colors.blue),
// //         ),
// //         const SizedBox(height: 6),
// //         Text(label, style: const TextStyle(fontSize: 12)),
// //       ],
// //     ),
// //   );
// // }
//
//
//
//




// // import 'package:flutter/material.dart';
// //
// // import 'account_screen.dart';
// // import 'cart_screen.dart';
// // import 'category_screen.dart';
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Book Store UI',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //         scaffoldBackgroundColor: Colors.white,
// //       ),
// //       home: const HomeScreen(),
// //     );
// //   }
// // }
// //
// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //
// //   int _selectedIndex = 0; // Home selected default
// //
// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //
// //     if (index == 1) {
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (_) => const CategoryPage()),
// //       );
// //     }
// //
// //     if (index == 2) {
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (_) => const AccountPage()),
// //       );
// //     }
// //
// //     if (index == 3) {
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (_) => const CartPage()),
// //       );
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               TextField(
// //                 decoration: InputDecoration(
// //                   hintText: 'Search books, papers, etc',
// //                   prefixIcon: const Icon(Icons.search),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 20),
// //
// //
// //               // CATEGORY ICON LIST
// //               SizedBox(
// //                 height: 90,
// //                 child: ListView(
// //                   scrollDirection: Axis.horizontal,
// //                   children: [
// //                     _buildCategory(Icons.book, "Books"),
// //                     _buildCategory(Icons.backpack_outlined, "Papers"),
// //                     _buildCategory(Icons.menu_book, "Notes"),
// //                     _buildCategory(Icons.video_library, "Videos"),
// //                     _buildCategory(Icons.more_horiz, "More"),
// //                   ],
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 20),
// //
// // // recoomention for you
// //               Container(
// //                 width: double.infinity,
// //                 height: 150,
// //                 decoration: BoxDecoration(
// //                   color: Colors.blue.shade50,
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: const Center(
// //                   child: Text(
// //                     'Recommended for You',
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 20),
// //
// //               Row(
// //                 children: const [
// //                   Icon(Icons.arrow_back_ios),
// //                   Spacer(),
// //                   Icon(Icons.arrow_forward_ios),
// //                 ],
// //               ),
// //
// //               const SizedBox(height: 10),
// //
// //               SizedBox(
// //                 height: 120,
// //                 child: ListView.builder(
// //                   scrollDirection: Axis.horizontal,
// //                   itemCount: 5,
// //                   itemBuilder: (context, index) {
// //                     return Container(
// //                       width: 100,
// //                       margin: const EdgeInsets.only(right: 12),
// //                       decoration: BoxDecoration(
// //                         color: Colors.grey.shade200,
// //                         borderRadius: BorderRadius.circular(12),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //
// //       bottomNavigationBar: BottomNavigationBar(
// //         type: BottomNavigationBarType.fixed,
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: Colors.purple,
// //         unselectedItemColor: Colors.grey,
// //         onTap: _onItemTapped,
// //         items: const [
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.home),
// //             label: 'Home',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.grid_view),
// //             label: 'Category',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.person),
// //             label: 'Account',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.shopping_cart),
// //             label: 'Cart',
// //           ),
// //         ],
// //       ),
// //
// //
// //     );
// //   }
// // }
// // Widget _buildCategory(IconData icon, String label) {
// //   return Container(
// //     width: 80,
// //     margin: const EdgeInsets.only(right: 12),
// //     child: Column(
// //       children: [
// //         CircleAvatar(
// //           radius: 25,
// //           backgroundColor: Colors.blue.shade50,
// //           child: Icon(icon, color: Colors.blue),
// //         ),
// //         const SizedBox(height: 6),
// //         Text(label, style: const TextStyle(fontSize: 12)),
// //       ],
// //     ),
// //   );
// // }
