
import 'package:e_commerce_app/data(remote)/repositary/user_repo.dart';
import 'package:e_commerce_app/ui/bloc/user/user_event.dart';
import 'package:e_commerce_app/ui/bloc/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepo userRepository;

  UserBloc({required this.userRepository}) : super(UserInitialState()) {
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

    on<LoginUserEvent>((event, emit) async{
      emit(UserLoadingState());
      try{
        dynamic res = await userRepository.loginUser(email: event.email, password: event.password);
        if(res['status']){
          emit(UserSuccessState());
        }else{
          emit(UserFailureState(errorMsg: res['message']));
        }
      } catch (e){
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });
  }


}