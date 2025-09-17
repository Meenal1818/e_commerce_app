import 'package:e_commerce_app/ui/bloc/product/product_event.dart';
import 'package:e_commerce_app/ui/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data(remote)/model/product_model.dart';
import '../../../data(remote)/repositary/product_repo.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepo productRepo;

  ProductBloc({required this.productRepo}) : super(ProductInitialState()) {
    on<FetchProductEvent>((event, emit) async {
      emit(ProductLoadingState());

      try {
        dynamic res = await productRepo.fetchProducts();
        if (res["status"]) {
          List<ProductModel> mProducts =
              ProductDataModel.fromJson(res).data ?? [];
          emit(ProductLoadedState(mProductList: mProducts));
        } else {
          emit(ProductErrorState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(ProductErrorState(errorMsg: e.toString()));
      }
    });
  }
}