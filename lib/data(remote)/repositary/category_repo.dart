

import '../../domain(constants)/app_urls.dart';
import '../helper/api_helper.dart';

class CategoryRepo {
  ApiHelper apiHelper;

  CategoryRepo({required this.apiHelper});

  Future<dynamic> fetchCategories() async {
    try {
      return await apiHelper.getApi(url: AppUrls.fetchCategoryUrl);
    } catch (e) {
      rethrow;
    }
  }
}