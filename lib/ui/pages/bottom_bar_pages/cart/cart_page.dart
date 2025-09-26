import 'package:e_commerce_app/ui/bloc/cart/cart_bloc.dart';
import 'package:e_commerce_app/ui/bloc/cart/cart_event.dart';
import 'package:e_commerce_app/ui/bloc/order/order_bloc.dart';
import 'package:e_commerce_app/ui/bloc/order/order_event.dart';
import 'package:e_commerce_app/ui/bloc/order/order_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data(remote)/model/cart_model.dart';
import '../../../../domain(constants)/app_routes.dart';
import '../../../bloc/cart/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  TextEditingController couponController = TextEditingController();
  Map<String, dynamic>? appliedCoupon;
  double discount = 0.0;
  List<Map<String, dynamic>> couponList = [
    {'code': 'ecomm10', 'value': 10, 'couponType': 1, 'minPrice': 15000},
    {'code': 'flat500', 'value': 500, 'couponType': 2, 'minPrice': 20000},
  ];
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCart());
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        leadingWidth: 55,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: Icon(CupertinoIcons.back, color: Colors.black, size: 20),
            ),
          ),
        ),
      ),

      // Body Content
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 420,
              width: double.infinity,
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    );
                  }

                  if (state is CartFailureState) {
                    return Center(child: Text(state.errorMsg));
                  }

                  if (state is CartSuccessState) {
                    return state.cartItems != null &&
                            state.cartItems!.isNotEmpty
                        ? ListView.builder(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),
                          itemCount: state.cartItems!.length,
                          itemBuilder: (context, index) {
                            // Normal cart items
                            final item = state.cartItems![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 10,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // Product Image
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.network(
                                        item.image,
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(width: 15),

                                    // Product Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'Product',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "₹${item.price}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Quantity + Delete
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                              DeleteCartItem(id: item.id),
                                            );
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.delete,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                        Container(
                                          width: 80,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'Items:',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                item.quantity.toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                        : Center(child: Text("No items in the cart"));
                  }

                  return Container();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, -2),
                  ),
                ],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  double subtotal = 0.0;
                  List<int> productIds = [];

                  if (state is CartSuccessState && state.cartItems != null) {
                    for (var item in state.cartItems!) {
                      subtotal +=
                          (double.tryParse(item.price.toString()) ?? 0) *
                          (item.quantity ?? 1);
                      productIds.add(item.productId);
                    }
                  }

                  // discount calculation
                  discount = 0.0;
                  if (appliedCoupon != null &&
                      subtotal >= (appliedCoupon!['minPrice'] ?? 0)) {
                    if (appliedCoupon!['couponType'] == 1) {
                      discount =
                          subtotal *
                          (appliedCoupon!['value'] / 100); // % discount
                    } else if (appliedCoupon!['couponType'] == 2) {
                      discount =
                          appliedCoupon!['value'].toDouble(); // flat discount
                    }
                  }

                  double total = subtotal - discount;
                  if (total < 0) total = 0;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 350,
                            child: TextField(
                              keyboardType: TextInputType.text,
                              controller: couponController,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: TextButton(
                                    onPressed: () {
                                      String enteredCode = couponController.text.trim().toLowerCase();
                                      final foundCoupon = couponList.firstWhere(
                                            (c) => c['code'].toString().toLowerCase() == enteredCode,
                                        orElse: () => {},
                                      );

                                      if (foundCoupon.isNotEmpty) {
                                        // check minPrice condition
                                        double subtotal = 0.0;
                                        final cartState = context.read<CartBloc>().state;
                                        if (cartState is CartSuccessState && cartState.cartItems != null) {
                                          for (var item in cartState.cartItems!) {
                                            subtotal +=
                                                (double.tryParse(item.price.toString()) ?? 0) * (item.quantity ?? 1);
                                          }
                                        }

                                        if (subtotal >= (foundCoupon['minPrice'] ?? 0)) {
                                          // valid coupon (subtotal >= minPrice)
                                          setState(() {
                                            appliedCoupon = foundCoupon;
                                          });

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Coupon Applied: ${foundCoupon['code']}"),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        } else {
                                          //subtotal kam hai
                                          setState(() {
                                            appliedCoupon = null;
                                          });

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "This coupon requires a minimum order of ₹${foundCoupon['minPrice']}",
                                              ),
                                              backgroundColor: Colors.orange,
                                            ),
                                          );
                                        }
                                      } else {
                                        // invalid coupon code
                                        setState(() {
                                          appliedCoupon = null;
                                        });

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Invalid Coupon Code"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },


                                    child: const Text(
                                      'Apply',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                hintText: 'Enter Discount Code',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Subtotal (actual product total)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Subtotal",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Text(
                            "₹${subtotal.toStringAsFixed(2)}", // ✅ actual total
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10,),

                      // Discount (if any)
                      if (discount > 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Discount",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              "-₹${discount.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                      const Divider(),

                      // Total after discount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "₹${total.toStringAsFixed(2)}",
                            // ✅ final total after discount
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // ✅ Checkout Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () {
                            final cartState = context.read<CartBloc>().state;
                            if (cartState is CartSuccessState &&
                                cartState.cartItems!.isNotEmpty) {
                              showConfirmOrderDialog(
                                context,
                                cartState.cartItems!,
                              );
                            }
                          },

                          child: const Text(
                            "Checkout",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showConfirmOrderDialog(BuildContext context, List<CartModel> cartItems) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text("Confirm Order"),
          content: Text("Are you sure you want to place this order?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            BlocConsumer<OrderBloc, OrderState>(
              listener: (ctx, state) {
                if (state is OrderFailureState) {
                  Navigator.pop(dialogContext);
                  print(state.errMsg.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errMsg),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                if (state is OrderSuccessState) {
                  Navigator.pop(dialogContext);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Order Placed Successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              builder: (ctx, state) {
                return ElevatedButton(
                  onPressed: () {
                    for (var item in cartItems) {
                      context.read<OrderBloc>().add(
                        CreateOrder(productId: item.productId, status: 1),
                      );
                    }
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
