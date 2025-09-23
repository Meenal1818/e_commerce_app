import 'package:e_commerce_app/data(remote)/repositary/order_repo.dart';
import 'package:e_commerce_app/ui/bloc/order/order_event.dart';
import 'package:e_commerce_app/ui/bloc/order/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent,OrderState>{
  OrderRepo orderRepo;
  OrderBloc({required this.orderRepo}): super(OrderInitialState()){
    on<CreateOrder>((event,emit)async{
      emit(OrderLoadingState());
      try{
        dynamic res=await orderRepo.createOrder(productId: event.productId,status: event.status);
        if(res['status']=='true'|| res['status']){
          emit(OrderSuccessState());
        }else{
          emit(OrderFailureState(errMsg: res['message']));
        }
      }catch (e){
        emit(OrderFailureState(errMsg: e.toString()));
      }
    });
  }
}