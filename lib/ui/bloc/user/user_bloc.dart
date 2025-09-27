
import 'package:e_commerce_app/data(remote)/repositary/user_repo.dart';
import 'package:e_commerce_app/ui/bloc/user/user_event.dart';
import 'package:e_commerce_app/ui/bloc/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data(remote)/model/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepo userRepository;

  UserBloc({required this.userRepository}) : super(UserInitialState()) {

    //Register
    on<RegisterUserEvent>((event, emit) async{
      emit(UserLoadingState());

      try {
        dynamic res = await userRepository.registerUser(
            name: event.name,
            email: event.email,
            password: event.password,
            mobNo: event.mobNo);

        if(res["status"]){
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: res["message"]));
        }

      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });

    //Login
    on<LoginUserEvent>((event, emit) async{
      emit(UserLoadingState());
      try{
        dynamic res = await userRepository.loginUser(email: event.email, password: event.password);
        if(res['status']){
          SharedPreferences prefs=await SharedPreferences.getInstance();
          prefs.setString('token', res['tokan']);
          emit(UserSuccessState());
        }else{
          emit(UserFailureState(errorMsg: res['message']));
        }
      } catch (e){
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });

    //Fetch User Profile
    on<FetchUserProfileEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        dynamic res = await userRepository.fetchUserProfile();

        if (res['status']) {
          UserModel user = UserModel.fromJson(res['data']);
          emit(UserSuccessState(user: user));
        } else {
          emit(UserFailureState(errorMsg: res['message'] ?? "Profile fetch failed"));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });



  }


}