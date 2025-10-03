import 'package:e_commerce_app/data(remote)/model/cart_model.dart';
import 'package:e_commerce_app/data(remote)/repositary/cart_repo.dart';
import 'package:e_commerce_app/ui/bloc/cart/cart_event.dart';
import 'package:e_commerce_app/ui/bloc/cart/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  CartRepo cartRepo;
  CartBloc({required this.cartRepo}) : super(CartInitialState()){

    //Add to cart
    on<AddToCart>((event,emit)async{
      emit(CartLoadingState());
      try{
        dynamic res =await cartRepo.addProductIntoCart(productId: event.productId, qty: event.qty);
        if(res['status']=='true'|| res['status']){
          emit(CartSuccessState());
        }else{
          emit(CartFailureState(errorMsg: res['message']));
        }
      }catch (e){
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });

    //Fetch Cart
    on<FetchCart>((event,emit)async{
      emit(CartLoadingState());

      try{
        dynamic res =await cartRepo.fetchCartProduct();
        if(res['status']=='true'|| res['status']){
          CartDataModel dataModel=CartDataModel.fromJson(res);
          List<CartModel> cartItemList= dataModel.data ?? [];
          emit(CartSuccessState(cartItems: cartItemList));
        }else{
          emit(CartFailureState(errorMsg: res['message']));
        }
      } catch (e){
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });


    //Decrement Cart Item
    on<IncDecCartItem>((event, emit) async {

      try {
        dynamic res = await cartRepo.incDecCartItem(
          productId: event.productId,
          qty: event.qty,
        );

        if (res["status"] == true || res['status']) {
          final updatedCart= await cartRepo.fetchCartProduct();
          CartDataModel dataModel=CartDataModel.fromJson(updatedCart);
          List<CartModel> cartItemList= dataModel.data ?? [];
          emit(CartSuccessState(cartItems: cartItemList));
        } else {
          emit(CartFailureState(errorMsg: res['message']));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });




    //Delete Cart Item
    on<DeleteCartItem>((event,emit)async{
      emit(CartInitialState());

      try{
        dynamic res =await cartRepo.deleteCartItem(cartId: event.id);
        if(res['status']=='true' || res['status']){
          final updatedCart= await cartRepo.fetchCartProduct();
          CartDataModel dataModel=CartDataModel.fromJson(updatedCart);
          List<CartModel> cartItemList= dataModel.data ?? [];
          emit(CartSuccessState(cartItems: cartItemList));
        }else{
          emit(CartFailureState(errorMsg: res['message']));
        }
      }catch (e){
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });
  }
}