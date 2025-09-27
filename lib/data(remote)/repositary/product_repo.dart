

import '../../domain(constants)/app_urls.dart';
import '../helper/api_helper.dart';

class ProductRepo {
  ApiHelper apiHelper;

  ProductRepo({required this.apiHelper});

  //Fetch Products

  Future<dynamic> fetchProducts({int? catId}) async {
    try {
      final Map<String,dynamic> body = catId != null ? {"category_id": catId} : {};
      return await apiHelper.postApi(
        url: AppUrls.fetchProductUrl,
        mBodyParams: body,
      );
    } catch (e) {
      rethrow;
    }
  }

}