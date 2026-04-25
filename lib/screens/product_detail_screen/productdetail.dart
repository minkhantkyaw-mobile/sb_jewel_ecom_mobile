// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:power_nine/router/route_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:power_nine/screens/nav/cart.dart';
// // Assuming GetX is used for navigation, as 'Get.back()' and 'Get.toNamed()' are present
// // You'll need to replace these with standard Navigator calls if GetX is not used.
// // import 'package:get/get.dart'; 

// class ProductDetailsPage extends StatefulWidget {
//   const ProductDetailsPage({super.key});

//   @override
//   State<ProductDetailsPage> createState() => _ProductDetailsPageState();
// }

// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   int selectedSize = 0; // 0 = S, 1 = M, 2 = L
//   int quantity = 1;

//   final List<String> sizes = ["S", "M", "L"];

//   // DOT Widget
//   Widget _dot(bool active) {
//     return Container(
//       width: active ? 10 : 8,
//       height: active ? 10 : 8,
//       decoration: BoxDecoration(
//         color: active ? const Color(0xffD66D8D) : Colors.grey,
//         shape: BoxShape.circle,
//       ),
//     );
//   }
  
//   // Single Card Builder for Recommendations (Product Card)
//   Widget _productCard(String image, String title, String price) {
//     return Container(
//       width: 150,
//       margin: const EdgeInsets.only(right: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image + Heart
//           Container(
//             height: 150,
//             decoration: BoxDecoration(
//               color: const Color(0xFFFCEFF2),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Stack(
//               children: [
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Image.asset(image),
//                   ),
//                 ),

//                 // Heart Icon
//                 Positioned(
//                   right: 10,
//                   top: 10,
//                   child: Icon(
//                     Icons.favorite_border,
//                     color: Colors.pink.shade300,
//                     size: 28,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 10),

//           // Product Name
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 5),

//           // Price
//           Text(
//             price,
//             style: const TextStyle(
//               fontSize: 15,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // --- Consolidated AppBar ---
//       appBar: AppBar(
//         // The original code used a custom Row in the body, but this is the standard way.
//         // Title and actions are centered here, matching the visual intent.
//         title: const Text(
//           "Product Details",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color(0xff8E4F63),
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           // Using standard pop for navigation if Get.back() is not strictly needed
//           onPressed: () => Navigator.of(context).pop(), 
//           // If you must use GetX: onPressed: () => Get.back(),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Get.to(() => CartPage());
//               // Using standard push for navigation if Get.toNamed() is not strictly needed
//               // Replace 'RouteHelper.noti' with the actual route/widget
//               // Navigator.of(context).push(MaterialPageRoute(builder: (_) => NotificationPage())); 
//               // If you must use GetX: Get.toNamed(RouteHelper.noti),
//             },
//             icon: const Icon(
//               Icons.shopping_bag_outlined,
//               color: Colors.black,
//             ),
//           ),
//         ],
//         backgroundColor: Colors.white,
//         elevation: 0, // Remove shadow
//       ),
//       backgroundColor: Colors.white,

//       // BOTTOM ADD TO CART
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           border: Border(top: BorderSide(color: Colors.grey)),
//         ),
//         child: Row(
//           children: [
//             // Quantity Selector
//             Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: const Color(0xff000000),
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.remove, color: Colors.white),
//                     onPressed: () {
//                       setState(() {
//                         if (quantity > 1) quantity--;
//                       });
//                     },
//                   ),
//                   Text(
//                     quantity.toString(),
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.add, color: Colors.white),
//                     onPressed: () {
//                       setState(() {
//                         quantity++;
//                       });
//                     },
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(width: 12),

//             // Add to Cart Button
//             Expanded(
//               child: InkWell(
//                 onTap: () {
//                   // Add to Cart logic
//                 },
//                 child: Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: const Color(0xffD66D8D),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       "Add to Cart",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),

//       body: SafeArea(
//         // Removed the unnecessary `Scaffold` padding by moving it into the `Padding` widgets below.
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // **REMOVED: Redundant AppBar Row**
//               // const SizedBox(height: 20), // Kept this space

//               // Product Image
//               Center(
//                 child: Container(
//                   height: 330,
//                   width: 330,
//                   decoration: BoxDecoration(
//                     color: const Color(0xffFCEFF2),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Image.asset("assets/img/clo.png"),
//                 ),
//               ),

//               const SizedBox(height: 10),

//               // dots
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _dot(true),
//                   const SizedBox(width: 5),
//                   _dot(false),
//                   const SizedBox(width: 5),
//                   _dot(false),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               // Product Title & Price
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text(
//                       "Brownie Wear",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       "35500 Ks",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xffD66D8D),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // Size Title
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   "Size",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 10),

//               // Size Selector
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   children: List.generate(sizes.length, (index) {
//                     final bool isSelected = selectedSize == index;
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 15),
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             selectedSize = index;
//                           });
//                         },
//                         child: Container(
//                           width: 70,
//                           height: 45,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: isSelected ? const Color(0xffD66D8D) : Colors.white,
//                             border: Border.all(
//                               color: isSelected
//                                   ? Colors.transparent
//                                   : Colors.grey.shade400,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             sizes[index],
//                             style: TextStyle(
//                               color: isSelected ? Colors.white : Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // Description Title
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   "Description",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 10),

//               // Description Content
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   "This is the product description.",
//                   style: TextStyle(fontSize: 15, color: Colors.black87),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // You may like Title
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   "You may Like",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 10),

//               // Sample Recommendation Items
//               SizedBox(
//                 height: 230,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   padding: const EdgeInsets.only(left: 16),
//                   children: [
//                     _productCard("assets/img/clo.png", "Brownie Wear", "35,500 Ks"),
//                     _productCard("assets/img/clo.png", "Brownie Wear", "35,500 Ks"),
//                     _productCard("assets/img/clo.png", "Brownie Wear", "35,500 Ks"),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 50),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // **REMOVED: Redundant _recommendedCard method**
// }