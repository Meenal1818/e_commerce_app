import 'package:e_commerce_app/data(remote)/helper/api_helper.dart';
import 'package:e_commerce_app/domain(constants)/app_urls.dart';

class OrderRepo{
  ApiHelper apiHelper;
  OrderRepo({required this.apiHelper});
  Future<dynamic> createOrder({required int productId,required int status})async{
    try{
     return await apiHelper.postApi(url: AppUrls.createOrderUrl,
      mBodyParams: {'product_id':productId,'status':status});

    }catch (e){
      rethrow;
    }
  }
}