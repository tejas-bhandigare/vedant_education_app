import 'package:vedant_education_app/models/product_model.dart';

List<Product> allProducts = [

  Product(
    id: "b1",
    name: "Merged Book A",
    price: 749,
    image: "assets/image/sakshi.png",
    category: "Books",
    subCategory: "Merged",
    description: "Complete merged book for full syllabus.",
  ),

  Product(
    id: "b2",
    name: "Math Book",
    price: 299,
    image: "assets/image/sakshi.png",
    category: "Books",
    subCategory: "Subject",
    description: "Complete mathematics book.",
  ),

  Product(
    id: "b3",
    name: "Nursery Writing Book",
    price: 499,
    image: "assets/image/sakshi.png",
    category: "Books",
    subCategory: "Nursery",
    description: "Writing practice book for nursery students.",
  ),

  Product(
    id: "b4",
    name: "Junior English Book",
    price: 699,
    image: "assets/image/sakshi.png",
    category: "Books",
    subCategory: "Junior",
    description: "Junior level English syllabus book.",
  ),



  /// ================== SCHOOL BAG ==================
  Product(
    id: "bag1",
    name: "Customized School Bag",
    description: "High quality customized school bag with logo.",
    image: "assets/bag1.png",
    price: 450,
    category: "Bag",
    subCategory: "School Bag",
  ),

  Product(
    id: "bag2",
    name: "Single Fold Bag",
    description: "Compact single fold school bag.",
    image: "assets/bag2.png",
    price: 350,
    category: "Bag",
    subCategory: "School Bag",
  ),

  /// ================== CERTIFICATE ==================
  Product(
    id: "cert1",
    name: "Customized Certificate",
    description: "200 GSM premium certificate paper.",
    image: "assets/cert1.png",
    price: 25,
    category: "Certificate",
    subCategory: "Customized",
  ),

  Product(
    id: "cert2",
    name: "Sports Certificate",
    description: "Sports and cultural event certificate.",
    image: "assets/cert2.png",
    price: 30,
    category: "Certificate",
    subCategory: "Standard",
  ),

  /// ================== UNIFORM ==================
  Product(
    id: "uni1",
    name: "School Uniform Red",
    description: "School uniform with logo print.",
    image: "assets/uniform1.png",
    price: 750,
    category: "Uniform",
    subCategory: "Boys & Girls",
  ),

  Product(
    id: "uni2",
    name: "Yellow Sports Uniform",
    description: "Mattel brand sports uniform.",
    image: "assets/uniform2.png",
    price: 850,
    category: "Uniform",
    subCategory: "Sports",
  ),
];