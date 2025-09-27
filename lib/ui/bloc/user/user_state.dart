import 'package:e_commerce_app/data(remote)/model/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}
class UserLoadingState extends UserState {}
class UserSuccessState extends UserState {
  final UserModel? user;
  UserSuccessState({this.user});
}
class UserFailureState extends UserState {
  final String errorMsg;
  UserFailureState({required this.errorMsg});
}
