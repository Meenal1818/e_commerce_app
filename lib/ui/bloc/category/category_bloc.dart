import 'package:e_commerce_app/data(remote)/model/category_model.dart';
import 'package:e_commerce_app/data(remote)/repositary/category_repo.dart';
import 'package:e_commerce_app/ui/bloc/category/category_event.dart';
import 'package:e_commerce_app/ui/bloc/category/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
  CategoryRepo categoryRepo;

  CategoryBloc({required this.categoryRepo}): super(CategoryInitialState()){
    on<GetAllCategory>((event,emit)async{
      emit(CategoryLoadingState());

      try{
        dynamic res= await categoryRepo.fetchCategories();
        if(res['status']){
          List<CategoryModel> mCategory= CategoryDataModel.fromJson(res).data ?? [];
          emit(CategoryLoadedState(mCategoryList: mCategory));
        }else{
          emit(CategoryErrorState(errorMsg: res['message']));
        }
      }catch (e){
        emit( CategoryErrorState(errorMsg: e.toString()));
      }
    });
  }
}