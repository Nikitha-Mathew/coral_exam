import 'package:coral_exam/api_service.dart';
import 'package:coral_exam/cart_controller.dart';
import 'package:coral_exam/model.dart';
import 'package:coral_exam/product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CartController cartController = Get.put(CartController());
  final ApiService apiService = ApiService();
  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    products = await apiService.fetchProducts();
    setState(() {
      filteredProducts =
          products; // Initialize filteredProducts with the fetched products
    });
  }

  void searchProduct(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredProducts = products
            .where((product) =>
                product.title!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredProducts = products; // Reset to original list
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Reduced height for AppBar
        child: AppBar(
          title: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 5),
            Text(
              'Explore Our Products',
              style: GoogleFonts.squarePeg(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 219, 203, 248),
              ),
            ),
          ]),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.indigo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart,
                  color: const Color.fromARGB(255, 208, 188, 239)),
              onPressed: () {
                Get.toNamed('/cart');
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextField for searching products
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.deepPurpleAccent),
                ),
              ),
              onChanged: searchProduct, // Call searchProduct on text change
            ),
          ),
          // Add Quote below the TextField
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '"The best way to predict the future is to create it."',
              style: GoogleFonts.charm(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                color: const Color.fromARGB(255, 61, 28, 153),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Body content (Product Grid)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 221, 150, 232),
                    Colors.purple.shade100
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: filteredProducts.isNotEmpty
                  ? GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pinkAccent.shade100,
                                      Colors.orangeAccent.shade100,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: ProductItem(
                                  product: filteredProducts[index],
                                  cartController:
                                      cartController, // Fixed missing argument
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No products found',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
