import 'package:coral_exam/cart_controller.dart';
import 'package:coral_exam/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final CartController cartController = Get.find<CartController>();

  ProductItem({required this.product, required CartController cartController});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.image!, height: 100, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.title!,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\$${product.price}'),
          ),
          ElevatedButton(
            onPressed: () {
              cartController.addToCart(product);
              Get.snackbar('Success', 'Added to cart');
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
