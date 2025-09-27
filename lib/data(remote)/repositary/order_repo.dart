import 'package:e_commerce_app/data(remote)/helper/api_helper.dart';
import 'package:e_commerce_app/domain(constants)/app_urls.dart';

class OrderRepo{
  ApiHelper apiHelper;
  OrderRepo({required this.apiHelper});

  // Create order
  Future<dynamic> createOrder({required int productId,required int status})async{
    try{
     return await apiHelper.postApi(url: AppUrls.createOrderUrl,
      mBodyParams: {'product_id':productId,'status':status});

    }catch (e){
      rethrow;
    }
  }

  //Fetch order
  Future<dynamic> fetchOrders()async{
    try{
      return await apiHelper.getApi(url: AppUrls.getOrderUrl);
    }catch (e){
      rethrow;
    }
  }
}