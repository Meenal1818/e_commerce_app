import 'package:e_commerce_app/data(remote)/helper/api_helper.dart';
import 'package:e_commerce_app/domain(constants)/app_urls.dart';

class CartRepo{
  ApiHelper apiHelper;
  CartRepo({required this.apiHelper});

  //Add product into cart

  Future<dynamic> addProductIntoCart ({required int productId , required int qty})async{
    try{
      return await apiHelper.postApi(url: AppUrls.addToCartUrl,
      mBodyParams:{'product_id':productId,'quantity':qty} );
    }catch (e){
      rethrow;
    }
  }

  //Fetch cart product

  Future<dynamic> fetchCartProduct()async{
    try{
      return await apiHelper.getApi(url: AppUrls.fetchCartUrl);
    }catch (e){
      rethrow;
    }
  }

  // decrement cart item
  Future<dynamic> incDecCartItem ({required int productId , required int qty})async{
    try{
      return await apiHelper.postApi(url: AppUrls.incDecCartUrl,
          mBodyParams:{'product_id':productId,'quantity':qty} );
    }catch (e){
      rethrow;
    }
  }

  //Delete cart item

  Future<dynamic> deleteCartItem({required int cartId})async{
    try{
      return await apiHelper.postApi(url: AppUrls.deleteCartUrl,
      mBodyParams: {"cart_id":cartId});
    }catch (e){
      rethrow;
    }
  }
}