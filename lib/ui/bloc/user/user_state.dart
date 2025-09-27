

abstract class UserState {}

class UserInitialState extends UserState {}
class UserLoadingState extends UserState {}
class UserSuccessState extends UserState {
}
class UserFailureState extends UserState {
  final String errorMsg;
  UserFailureState({required this.errorMsg});
}
