import 'package:e_commerce_app/data(remote)/helper/api_helper.dart';
import 'package:e_commerce_app/domain(constants)/app_urls.dart';

class UserRepo{
  ApiHelper apiHelper;
  UserRepo({required this.apiHelper});

  //register
  Future<dynamic> registerUser({
    required String name,
    required String email,
    required String mobNo,
    required String password
})async{
    try{
      return await apiHelper.postApi(url: AppUrls.registrationUrl,
      mBodyParams: {
        'name':name,
        'mobile_number':mobNo,
        'email':email,
        'password':password
      },isAuth: true);
    }catch (e){
      rethrow;
    }
  }

  //login
Future<dynamic> loginUser({required String email,required String password})async{
    try{
      return await apiHelper.postApi(url: AppUrls.loginUrl,
      mBodyParams: {
        'email':email,
        'password':password,
      },isAuth: true);
    }catch (e){
      rethrow;
    }
}

}