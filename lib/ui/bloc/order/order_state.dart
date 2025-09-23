abstract class OrderState{}

class OrderInitialState extends OrderState{}

class OrderLoadingState extends OrderState{}

class OrderSuccessState extends OrderState{}

class OrderFailureState extends OrderState{
  String errMsg;
  OrderFailureState({required this.errMsg});
}
