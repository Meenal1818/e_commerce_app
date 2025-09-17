

import '../../../data(remote)/model/category_model.dart';
import '../../../data(remote)/model/product_model.dart';

abstract class CategoryState{}

class CategoryInitialState extends CategoryState{}
class CategoryLoadingState extends CategoryState{}
class CategoryLoadedState extends CategoryState{
  List<CategoryModel> mCategoryList;
  CategoryLoadedState({required this.mCategoryList});
}
class CategoryErrorState extends CategoryState{
  String errorMsg;
  CategoryErrorState({required this.errorMsg});
}