import 'package:e_commerce_app/data(remote)/model/cart_model.dart';

abstract class CartState{}

class CartInitialState extends CartState{}
class CartLoadingState extends CartState{}
class CartSuccessState extends CartState{
  List<CartModel>? cartItems;
  CartSuccessState({this.cartItems});
}
class CartFailureState extends CartState{
  String errorMsg;
  CartFailureState({required this.errorMsg});
}