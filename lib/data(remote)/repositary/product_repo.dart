

import '../../domain(constants)/app_urls.dart';
import '../helper/api_helper.dart';

class ProductRepo {
  ApiHelper apiHelper;

  ProductRepo({required this.apiHelper});

  Future<dynamic> fetchProducts() async {
    try {
      return await apiHelper.postApi(url: AppUrls.fetchProductUrl);
    } catch (e) {
      rethrow;
    }
  }
}