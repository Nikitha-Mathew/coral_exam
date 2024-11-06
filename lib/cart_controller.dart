import 'package:coral_exam/model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems =
      <ProductModel, int>{}.obs; // Map to hold product and its quantity

  // Add product to cart
  void addToCart(ProductModel product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1; // Increase the count
    } else {
      cartItems[product] = 1; // Initialize count for new product
    }
    update();
  }

  // Remove product from cart (decrease count or remove if 0)
  void removeFromCart(ProductModel product) {
    if (cartItems.containsKey(product)) {
      int currentCount = cartItems[product]!;
      if (currentCount > 1) {
        cartItems[product] = currentCount - 1; // Decrease the count
      } else {
        cartItems.remove(product); // Remove the product if count is 1 or less
      }
    }
    update();
  }

  // Clear the entire cart
  void clearCart() {
    cartItems.clear();
    update();
  }

  // Get the total amount of the cart
  double get totalAmount {
    double total = 0.0;
    cartItems.forEach((product, count) {
      total += (product.price ?? 0) * count; // Calculate total based on count
    });
    return total;
  }
}
