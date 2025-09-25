import 'package:e_commerce_app/data(remote)/model/order_model.dart';

abstract class OrderState{}

class OrderInitialState extends OrderState{}

class OrderLoadingState extends OrderState{}

class OrderSuccessState extends OrderState{

}
class OrderLoadedState extends OrderState{
  List<OrderModel> orderItems;
  OrderLoadedState({required this.orderItems});
}

class OrderFailureState extends OrderState{
  String errMsg;
  OrderFailureState({required this.errMsg});
}
